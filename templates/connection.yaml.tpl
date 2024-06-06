{{- range $name, $value := .Values.connection }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: Connection
{{ include "resourceValues" (list $name $value) }}
{{- end }}