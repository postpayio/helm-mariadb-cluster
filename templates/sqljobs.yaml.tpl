{{- range $name, $value := .Values.sqlJob }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: sqlJob
{{ include "resourceValues" (list $name $value) }}
{{- end }}