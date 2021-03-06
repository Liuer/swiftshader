; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,CI %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX9 %s

; GCN-LABEL: {{^}}atomic_load_monotonic_i32:
; GCN: s_waitcnt
; GFX9-NOT: s_mov_b32 m0
; CI-NEXT: s_mov_b32 m0
; GCN-NEXT: ds_read_b32 v0, v0{{$}}
; GCN-NEXT: s_waitcnt lgkmcnt(0)
; GCN-NEXT: s_setpc_b64
define i32 @atomic_load_monotonic_i32(i32 addrspace(3)* %ptr) {
  %load = load atomic i32, i32 addrspace(3)* %ptr monotonic, align 4
  ret i32 %load
}

; GCN-LABEL: {{^}}atomic_load_monotonic_i32_offset:
; GCN: s_waitcnt
; GFX9-NOT: s_mov_b32 m0
; CI-NEXT: s_mov_b32 m0
; GCN-NEXT: ds_read_b32 v0, v0 offset:64{{$}}
; GCN-NEXT: s_waitcnt lgkmcnt(0)
; GCN-NEXT: s_setpc_b64
define i32 @atomic_load_monotonic_i32_offset(i32 addrspace(3)* %ptr) {
  %gep = getelementptr inbounds i32, i32 addrspace(3)* %ptr, i32 16
  %load = load atomic i32, i32 addrspace(3)* %gep monotonic, align 4
  ret i32 %load
}

; GCN-LABEL: {{^}}atomic_load_monotonic_i64:
; GCN: s_waitcnt
; GFX9-NOT: s_mov_b32 m0
; CI-NEXT: s_mov_b32 m0
; GCN-NEXT: ds_read_b64 v[0:1], v0{{$}}
; GCN-NEXT: s_waitcnt lgkmcnt(0)
; GCN-NEXT: s_setpc_b64
define i64 @atomic_load_monotonic_i64(i64 addrspace(3)* %ptr) {
  %load = load atomic i64, i64 addrspace(3)* %ptr monotonic, align 8
  ret i64 %load
}

; GCN-LABEL: {{^}}atomic_load_monotonic_i64_offset:
; GCN: s_waitcnt
; GFX9-NOT: s_mov_b32 m0
; CI-NEXT: s_mov_b32 m0
; GCN-NEXT: ds_read_b64 v[0:1], v0 offset:128{{$}}
; GCN-NEXT: s_waitcnt lgkmcnt(0)
; GCN-NEXT: s_setpc_b64
define i64 @atomic_load_monotonic_i64_offset(i64 addrspace(3)* %ptr) {
  %gep = getelementptr inbounds i64, i64 addrspace(3)* %ptr, i64 16
  %load = load atomic i64, i64 addrspace(3)* %gep monotonic, align 8
  ret i64 %load
}
