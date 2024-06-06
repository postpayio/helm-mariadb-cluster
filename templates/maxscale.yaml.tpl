{{- range $name, $value := .Values.maxScale }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: MaxScale
{{ include "resourceValues" (list $name $value) }}
{{- end }}