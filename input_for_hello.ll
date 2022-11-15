; ModuleID = '/Users/xiakejie/ME/break/llvm-tutor/inputs/input_for_hello.c'
source_filename = "/Users/xiakejie/ME/break/llvm-tutor/inputs/input_for_hello.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @foo(i32 %0) local_unnamed_addr #0 {
  %2 = shl nsw i32 %0, 1
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @bar(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = shl i32 %1, 2
  %4 = add nsw i32 %3, %0
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @fez(i32 %0, i32 %1, i32 %2) local_unnamed_addr #0 {
  %4 = shl i32 %1, 2
  %5 = add nsw i32 %4, %0
  %6 = shl nsw i32 %5, 1
  %7 = mul nsw i32 %2, 3
  %8 = add i32 %7, %0
  %9 = add i32 %8, %6
  ret i32 %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define i32 @main(i32 %0, i8** nocapture readnone %1) local_unnamed_addr #0 {
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
!8 = !{!"Homebrew clang version 13.0.1"}
