(defpackage blazegraph-fuseki
  (:use :cl :cl-fuseki)
	(:shadowing-import-from :cl-fuseki :delete)
  (:export :blazegraph-server :blazegraph-repository))
