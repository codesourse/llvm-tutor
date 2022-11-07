; ModuleID = './inputs/input_for_hello.c'
source_filename = "./inputs/input_for_hello.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @foo(i32 %a) local_unnamed_addr #0 {
entry:
  %mul = shl nsw i32 %a, 1
  ret i32 %mul
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @bar(i32 %a, i32 %b) local_unnamed_addr #0 {
entry:
  %mul.i = shl i32 %b, 2
  %add = add nsw i32 %mul.i, %a
  ret i32 %add
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @fez(i32 %a, i32 %b, i32 %c) local_unnamed_addr #0 {
entry:
  %mul.i.i = shl i32 %b, 2
  %add.i = add nsw i32 %mul.i.i, %a
  %mul = shl nsw i32 %add.i, 1
  %mul1 = mul nsw i32 %c, 3
  %add = add i32 %mul1, %a
  %add2 = add i32 %add, %mul
  ret i32 %add2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @main(i32 %argc, i8** nocapture readnone %argv) local_unnamed_addr #0 {
entry:
  ret i32 12915
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"branch-target-enforcement", i32 0}
!2 = !{i32 1, !"sign-return-address", i32 0}
!3 = !{i32 1, !"sign-return-address-all", i32 0}
!4 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"uwtable", i32 1}
!7 = !{i32 7, !"frame-pointer", i32 1}
!8 = !{!"clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)"}
