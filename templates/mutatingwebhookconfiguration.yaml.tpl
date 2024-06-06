{{- range $name, $value := .Values.MutatingWebhookConfiguration }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: MutatingWebhookConfiguration
{{ include "resourceValues" (list $name $value) }}
{{- end }}