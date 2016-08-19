(asdf:defsystem :cl-fuseki-blazegraph-plugin
  :name "cl-fuseki-blazegraph-plugin"
  :author "Aad Versteden <madnificent@gmail.com>"
  :version "0.0.1"
  :maintainer "Aad Versteden <madnificent@gmail.com>"
  :licence "MIT"
  :description "Plugin for cl-fuseki to run on Blazegraph."
  :serial t
  :depends-on (:cl-fuseki :drakma)
  :components ((:file "packages")
               (:file "blazegraph-fuseki")))
