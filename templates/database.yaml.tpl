{{- range $name, $value := .Values.database }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: Database
{{ include "resourceValues" (list $name $value) }}
{{- end }}