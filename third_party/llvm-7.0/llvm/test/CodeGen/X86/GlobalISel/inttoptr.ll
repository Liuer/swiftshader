; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=CHECK

define i64* @inttoptr_p0_s64(i64 %val) {
; CHECK-LABEL: inttoptr_p0_s64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    retq
entry:
  %0 = inttoptr i64 %val to i64*
  ret i64* %0
}