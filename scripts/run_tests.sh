#!/bin/bash
set -e

echo "🧪 Running Itqan Tests..."
echo ""

cd "$(dirname "$0")/../app"

echo "📦 Unit + Widget Tests"
flutter test test/ --reporter=compact

echo ""
echo "✅ All tests passed!"
echo ""
echo "📱 Integration tests (require connected device):"
echo "   flutter test integration_test/ --device-id <device-id>"
