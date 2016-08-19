(in-package :blazegraph-fuseki)

(defclass blazegraph-server (cl-fuseki::server)
  ()
  (:documentation "endpoint used for making Blazegraph calls."))

(defclass blazegraph-repository (cl-fuseki::virtuoso-repository)
  ()
  (:documentation "repository for Blazegraph endpoints."))

(defmethod cl-fuseki::server-query-endpoint-postfix ((server blazegraph-server))
	"/bigdata/sparql")
(defmethod cl-fuseki::server-update-endpoint-postfix ((server blazegraph-server))
	"/bigdata/sparql")
(defmethod cl-fuseki::server-data-endpoint-postfix ((server blazegraph-server))
	"/bigdata/sparql")
(defmethod cl-fuseki::server-upload-endpoint-postfix ((server blazegraph-server))
	"/bigdata/sparql")

(defmethod cl-fuseki::query-raw ((repos blazegraph-repository) (query string) &rest options &key &allow-other-keys)
  (cl-fuseki::flush-updates repos)
  (let ((full-query (apply #'cl-fuseki::query-update-prefixes query options)))
    (cl-fuseki::maybe-log-query full-query)
    (sparql-query repos full-query)))

(defmethod cl-fuseki::update-now ((repos blazegraph-repository) (update string))
  (sparql-update repos update))

(defun sparql-query (repos full-query)
	(cl-fuseki::send-request (cl-fuseki::query-endpoint repos)
													 :accept (cl-fuseki::get-data-type-binding :json)
													 :parameters `(("query" . ,full-query))))
	
(defun sparql-update (repos update-query)
	(cl-fuseki::send-request (cl-fuseki::query-endpoint repos)
													 :accept (cl-fuseki::get-data-type-binding :json)
													 :method :post
													 :parameters `(("update" . ,update-query))))
