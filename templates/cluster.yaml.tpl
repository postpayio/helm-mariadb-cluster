{{- range $name, $value := .Values.cluster }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: MariaDB
{{ include "resourceValues" (list $name $value) }}
{{- end }}