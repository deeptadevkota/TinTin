; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.bpf_fib_lookup = type { i8, i8, i16, i16, i16, i32, %union.anon, %union.anon.0, %union.anon.1, i16, i16, [6 x i8], [6 x i8] }
%union.anon = type { i32 }
%union.anon.0 = type { [4 x i32] }
%union.anon.1 = type { [4 x i32] }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.newip_offset = type { i8, i8, i8 }
%struct.shipping_spec = type { i8, i8, i8 }
%struct.meta_info = type { i32, %struct.max_delay_forwarding }
%struct.max_delay_forwarding = type { i16, i16, i16 }
%struct.in6_addr = type { %union.anon.2 }
%union.anon.2 = type { [4 x i32] }
%struct.ping_contract = type { i16, i16, i16, i64 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4
@static_redirect_8b = dso_local global %struct.bpf_map_def { i32 1, i32 1, i32 4, i32 256, i32 0 }, section "maps", align 4
@__const.xdp_router_func.____fmt = private unnamed_addr constant [11 x i8] c"proto: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.1 = private unnamed_addr constant [14 x i8] c"src type: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.2 = private unnamed_addr constant [14 x i8] c"dst type: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.3 = private unnamed_addr constant [12 x i8] c"%d, %d, %d\0A\00", align 1
@__const.xdp_router_func.____fmt.4 = private unnamed_addr constant [14 x i8] c"ipv4 dst: %x\0A\00", align 1
@__const.xdp_router_func.____fmt.5 = private unnamed_addr constant [12 x i8] c"8b dst: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.6 = private unnamed_addr constant [12 x i8] c"no ifindex\0A\00", align 1
@__const.xdp_router_func.____fmt.7 = private unnamed_addr constant [19 x i8] c"contract type: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.8 = private unnamed_addr constant [13 x i8] c"ifindex: %d\0A\00", align 1
@__const.xdp_router_func.____fmt.10 = private unnamed_addr constant [20 x i8] c"lookup successfull\0A\00", align 1
@__const.xdp_router_func.____fmt.11 = private unnamed_addr constant [60 x i8] c"route not found, check if routing suite is working properly\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1
@llvm.compiler.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @static_redirect_8b to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_router_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_router_func(%struct.xdp_md* %0) #0 section "xdp_router" {
  %2 = alloca i32, align 4
  %3 = alloca %struct.bpf_fib_lookup, align 4
  %4 = alloca [11 x i8], align 1
  %5 = alloca [14 x i8], align 1
  %6 = alloca [14 x i8], align 1
  %7 = alloca [12 x i8], align 1
  %8 = alloca [14 x i8], align 1
  %9 = alloca [12 x i8], align 1
  %10 = alloca [12 x i8], align 1
  %11 = alloca [19 x i8], align 1
  %12 = alloca [13 x i8], align 1
  %13 = alloca i64, align 8
  %14 = alloca [20 x i8], align 1
  %15 = alloca [60 x i8], align 1
  %16 = tail call i64 inttoptr (i64 54 to i64 (%struct.xdp_md*, i32)*)(%struct.xdp_md* %0, i32 -12) #6
  %17 = trunc i64 %16 to i32
  %18 = icmp slt i32 %17, 0
  br i1 %18, label %216, label %19

19:                                               ; preds = %1
  %20 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1
  %21 = load i32, i32* %20, align 4, !tbaa !3
  %22 = zext i32 %21 to i64
  %23 = inttoptr i64 %22 to i8*
  %24 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0
  %25 = load i32, i32* %24, align 4, !tbaa !8
  %26 = zext i32 %25 to i64
  %27 = inttoptr i64 %26 to i8*
  %28 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %28) #6
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(64) %28, i8 0, i64 64, i1 false)
  %29 = inttoptr i64 %26 to %struct.ethhdr*
  %30 = getelementptr i8, i8* %27, i64 14
  %31 = icmp ugt i8* %30, %23
  br i1 %31, label %194, label %32

32:                                               ; preds = %19
  %33 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %29, i64 0, i32 2
  %34 = load i16, i16* %33, align 1, !tbaa !9
  %35 = getelementptr inbounds [11 x i8], [11 x i8]* %4, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 11, i8* nonnull %35) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(11) %35, i8* noundef nonnull align 1 dereferenceable(11) getelementptr inbounds ([11 x i8], [11 x i8]* @__const.xdp_router_func.____fmt, i64 0, i64 0), i64 11, i1 false)
  %36 = zext i16 %34 to i32
  %37 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %35, i32 11, i32 %36) #6
  call void @llvm.lifetime.end.p0i8(i64 11, i8* nonnull %35) #6
  %38 = icmp eq i16 %34, -18808
  br i1 %38, label %39, label %194

39:                                               ; preds = %32
  %40 = getelementptr i8, i8* %27, i64 17
  %41 = bitcast i8* %40 to %struct.newip_offset*
  %42 = inttoptr i64 %22 to %struct.newip_offset*
  %43 = icmp ugt %struct.newip_offset* %41, %42
  br i1 %43, label %194, label %44

44:                                               ; preds = %39
  %45 = load i8, i8* %30, align 1, !tbaa !12
  %46 = zext i8 %45 to i64
  %47 = getelementptr i8, i8* %30, i64 %46
  %48 = getelementptr inbounds i8, i8* %47, i64 3
  %49 = bitcast i8* %48 to %struct.shipping_spec*
  %50 = inttoptr i64 %22 to %struct.shipping_spec*
  %51 = icmp ugt %struct.shipping_spec* %49, %50
  br i1 %51, label %194, label %52

52:                                               ; preds = %44
  %53 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 2
  %54 = load i32, i32* %53, align 4, !tbaa !14
  %55 = zext i32 %54 to i64
  %56 = inttoptr i64 %55 to %struct.meta_info*
  %57 = getelementptr inbounds %struct.meta_info, %struct.meta_info* %56, i64 1
  %58 = inttoptr i64 %26 to %struct.meta_info*
  %59 = icmp ugt %struct.meta_info* %57, %58
  br i1 %59, label %214, label %60

60:                                               ; preds = %52
  %61 = load i8, i8* %47, align 1, !tbaa !15
  %62 = zext i8 %61 to i32
  %63 = getelementptr inbounds [14 x i8], [14 x i8]* %5, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %63) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(14) %63, i8* noundef nonnull align 1 dereferenceable(14) getelementptr inbounds ([14 x i8], [14 x i8]* @__const.xdp_router_func.____fmt.1, i64 0, i64 0), i64 14, i1 false)
  %64 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %63, i32 14, i32 %62) #6
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %63) #6
  %65 = getelementptr inbounds i8, i8* %47, i64 1
  %66 = load i8, i8* %65, align 1, !tbaa !17
  %67 = zext i8 %66 to i32
  %68 = getelementptr inbounds [14 x i8], [14 x i8]* %6, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %68) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(14) %68, i8* noundef nonnull align 1 dereferenceable(14) getelementptr inbounds ([14 x i8], [14 x i8]* @__const.xdp_router_func.____fmt.2, i64 0, i64 0), i64 14, i1 false)
  %69 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %68, i32 14, i32 %67) #6
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %68) #6
  %70 = load i8, i8* %47, align 1, !tbaa !15
  switch i8 %70, label %73 [
    i8 0, label %74
    i8 1, label %71
    i8 2, label %72
  ]

71:                                               ; preds = %60
  br label %74

72:                                               ; preds = %60
  br label %74

73:                                               ; preds = %60
  br label %74

74:                                               ; preds = %60, %73, %71, %72
  %75 = phi i32 [ 16, %71 ], [ 1, %72 ], [ 4, %60 ], [ 0, %73 ]
  %76 = load i8, i8* %65, align 1, !tbaa !17
  switch i8 %76, label %194 [
    i8 0, label %77
    i8 1, label %93
    i8 2, label %104
  ]

77:                                               ; preds = %74
  %78 = add nuw nsw i32 %75, 20
  %79 = zext i32 %78 to i64
  %80 = getelementptr i8, i8* %27, i64 %79
  %81 = getelementptr inbounds [12 x i8], [12 x i8]* %7, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %81) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(12) %81, i8* noundef nonnull align 1 dereferenceable(12) getelementptr inbounds ([12 x i8], [12 x i8]* @__const.xdp_router_func.____fmt.3, i64 0, i64 0), i64 12, i1 false)
  %82 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %81, i32 12, i64 3, i64 3, i32 %75) #6
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %81) #6
  %83 = getelementptr inbounds i8, i8* %80, i64 4
  %84 = bitcast i8* %83 to i32*
  %85 = inttoptr i64 %22 to i32*
  %86 = icmp ugt i32* %84, %85
  br i1 %86, label %194, label %87

87:                                               ; preds = %77
  %88 = bitcast i8* %80 to i32*
  store i8 2, i8* %28, align 4, !tbaa !18
  %89 = load i32, i32* %88, align 4, !tbaa !20
  %90 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 8, i32 0, i64 0
  store i32 %89, i32* %90, align 4, !tbaa !21
  %91 = getelementptr inbounds [14 x i8], [14 x i8]* %8, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %91) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(14) %91, i8* noundef nonnull align 1 dereferenceable(14) getelementptr inbounds ([14 x i8], [14 x i8]* @__const.xdp_router_func.____fmt.4, i64 0, i64 0), i64 14, i1 false)
  %92 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %91, i32 14, i32 %89) #6
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %91) #6
  br label %124

93:                                               ; preds = %74
  %94 = add nuw nsw i32 %75, 20
  %95 = zext i32 %94 to i64
  %96 = getelementptr i8, i8* %27, i64 %95
  %97 = getelementptr inbounds i8, i8* %96, i64 16
  %98 = bitcast i8* %97 to %struct.in6_addr*
  %99 = inttoptr i64 %22 to %struct.in6_addr*
  %100 = icmp ugt %struct.in6_addr* %98, %99
  br i1 %100, label %194, label %101

101:                                              ; preds = %93
  %102 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 8, i32 0, i64 0
  store i8 10, i8* %28, align 4, !tbaa !18
  %103 = bitcast i32* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(16) %103, i8* noundef nonnull align 4 dereferenceable(16) %96, i64 16, i1 false), !tbaa.struct !22
  br label %124

104:                                              ; preds = %74
  %105 = add nuw nsw i32 %75, 20
  %106 = zext i32 %105 to i64
  %107 = getelementptr i8, i8* %27, i64 %106
  %108 = getelementptr inbounds i8, i8* %107, i64 1
  %109 = icmp ugt i8* %108, %23
  br i1 %109, label %194, label %110

110:                                              ; preds = %104
  %111 = getelementptr inbounds [12 x i8], [12 x i8]* %9, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %111) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(12) %111, i8* noundef nonnull align 1 dereferenceable(12) getelementptr inbounds ([12 x i8], [12 x i8]* @__const.xdp_router_func.____fmt.5, i64 0, i64 0), i64 12, i1 false)
  %112 = load i8, i8* %107, align 1, !tbaa !21
  %113 = zext i8 %112 to i32
  %114 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %111, i32 12, i32 %113) #6
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %111) #6
  %115 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @static_redirect_8b to i8*), i8* nonnull %107) #6
  %116 = icmp eq i8* %115, null
  br i1 %116, label %117, label %120

117:                                              ; preds = %110
  %118 = getelementptr inbounds [12 x i8], [12 x i8]* %10, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %118) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(12) %118, i8* noundef nonnull align 1 dereferenceable(12) getelementptr inbounds ([12 x i8], [12 x i8]* @__const.xdp_router_func.____fmt.6, i64 0, i64 0), i64 12, i1 false)
  %119 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %118, i32 12) #6
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %118) #6
  br label %214

120:                                              ; preds = %110
  %121 = bitcast i8* %115 to i32*
  %122 = load i32, i32* %121, align 4, !tbaa !20
  %123 = getelementptr inbounds %struct.meta_info, %struct.meta_info* %56, i64 0, i32 0
  store i32 %122, i32* %123, align 4, !tbaa !23
  br label %124

124:                                              ; preds = %120, %101, %87
  %125 = getelementptr i8, i8* %27, i64 15
  %126 = load i8, i8* %125, align 1, !tbaa !26
  %127 = getelementptr i8, i8* %27, i64 16
  %128 = load i8, i8* %127, align 1, !tbaa !27
  %129 = icmp ult i8 %126, %128
  br i1 %129, label %130, label %168

130:                                              ; preds = %124
  %131 = zext i8 %126 to i64
  %132 = getelementptr i8, i8* %30, i64 %131
  %133 = getelementptr inbounds i8, i8* %132, i64 2
  %134 = bitcast i8* %133 to i16*
  %135 = inttoptr i64 %22 to i16*
  %136 = icmp ugt i16* %134, %135
  br i1 %136, label %194, label %137

137:                                              ; preds = %130
  %138 = bitcast i8* %132 to i16*
  %139 = load i16, i16* %138, align 2, !tbaa !28
  %140 = call i16 @llvm.bswap.i16(i16 %139)
  %141 = getelementptr inbounds [19 x i8], [19 x i8]* %11, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 19, i8* nonnull %141) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(19) %141, i8* noundef nonnull align 1 dereferenceable(19) getelementptr inbounds ([19 x i8], [19 x i8]* @__const.xdp_router_func.____fmt.7, i64 0, i64 0), i64 19, i1 false)
  %142 = zext i16 %140 to i32
  %143 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %141, i32 19, i32 %142) #6
  call void @llvm.lifetime.end.p0i8(i64 19, i8* nonnull %141) #6
  switch i16 %140, label %168 [
    i16 3, label %144
    i16 1, label %156
  ]

144:                                              ; preds = %137
  %145 = getelementptr inbounds i8, i8* %132, i64 16
  %146 = bitcast i8* %145 to %struct.ping_contract*
  %147 = inttoptr i64 %22 to %struct.ping_contract*
  %148 = icmp ugt %struct.ping_contract* %146, %147
  br i1 %148, label %194, label %149

149:                                              ; preds = %144
  %150 = getelementptr inbounds i8, i8* %132, i64 4
  %151 = bitcast i8* %150 to i16*
  %152 = load i16, i16* %151, align 4, !tbaa !29
  %153 = call i16 @llvm.bswap.i16(i16 %152)
  %154 = add i16 %153, -1
  %155 = call i16 @llvm.bswap.i16(i16 %154)
  store i16 %155, i16* %151, align 4, !tbaa !29
  br label %168

156:                                              ; preds = %137
  %157 = getelementptr inbounds i8, i8* %132, i64 6
  %158 = bitcast i8* %157 to %struct.max_delay_forwarding*
  %159 = inttoptr i64 %22 to %struct.max_delay_forwarding*
  %160 = icmp ugt %struct.max_delay_forwarding* %158, %159
  br i1 %160, label %194, label %161

161:                                              ; preds = %156
  %162 = load i16, i16* %134, align 2, !tbaa !32
  %163 = getelementptr inbounds %struct.meta_info, %struct.meta_info* %56, i64 0, i32 1, i32 1
  store i16 %162, i16* %163, align 2, !tbaa !33
  %164 = getelementptr inbounds i8, i8* %132, i64 4
  %165 = bitcast i8* %164 to i16*
  %166 = load i16, i16* %165, align 2, !tbaa !34
  %167 = getelementptr inbounds %struct.meta_info, %struct.meta_info* %56, i64 0, i32 1, i32 2
  store i16 %166, i16* %167, align 4, !tbaa !35
  br label %168

168:                                              ; preds = %137, %149, %161, %124
  %169 = icmp eq i8 %76, 2
  br i1 %169, label %194, label %170

170:                                              ; preds = %168
  %171 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 3
  %172 = load i32, i32* %171, align 4, !tbaa !36
  %173 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 5
  store i32 %172, i32* %173, align 4, !tbaa !37
  %174 = getelementptr inbounds [13 x i8], [13 x i8]* %12, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 13, i8* nonnull %174) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(13) %174, i8* noundef nonnull align 1 dereferenceable(13) getelementptr inbounds ([13 x i8], [13 x i8]* @__const.xdp_router_func.____fmt.8, i64 0, i64 0), i64 13, i1 false)
  %175 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %174, i32 13, i32 %172) #6
  call void @llvm.lifetime.end.p0i8(i64 13, i8* nonnull %174) #6
  %176 = bitcast %struct.xdp_md* %0 to i8*
  %177 = call i64 inttoptr (i64 69 to i64 (i8*, %struct.bpf_fib_lookup*, i32, i32)*)(i8* %176, %struct.bpf_fib_lookup* nonnull %3, i32 64, i32 0) #6
  %178 = trunc i64 %177 to i32
  %179 = bitcast i64* %13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %179) #6
  store i64 2924860384371570, i64* %13, align 8
  %180 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %179, i32 8, i32 %178) #6
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %179) #6
  switch i32 %178, label %194 [
    i32 0, label %181
    i32 1, label %190
    i32 2, label %190
    i32 3, label %190
    i32 4, label %191
  ]

181:                                              ; preds = %170
  %182 = getelementptr inbounds [20 x i8], [20 x i8]* %14, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %182) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(20) %182, i8* noundef nonnull align 1 dereferenceable(20) getelementptr inbounds ([20 x i8], [20 x i8]* @__const.xdp_router_func.____fmt.10, i64 0, i64 0), i64 20, i1 false)
  %183 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %182, i32 20) #6
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %182) #6
  %184 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %29, i64 0, i32 0, i64 0
  %185 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 12, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %184, i8* noundef nonnull align 2 dereferenceable(6) %185, i64 6, i1 false)
  %186 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %29, i64 0, i32 1, i64 0
  %187 = getelementptr inbounds %struct.bpf_fib_lookup, %struct.bpf_fib_lookup* %3, i64 0, i32 11, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %186, i8* noundef nonnull align 4 dereferenceable(6) %187, i64 6, i1 false)
  %188 = load i32, i32* %173, align 4, !tbaa !37
  %189 = getelementptr inbounds %struct.meta_info, %struct.meta_info* %56, i64 0, i32 0
  store i32 %188, i32* %189, align 4, !tbaa !23
  br label %194

190:                                              ; preds = %170, %170, %170
  br label %194

191:                                              ; preds = %170
  %192 = getelementptr inbounds [60 x i8], [60 x i8]* %15, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 60, i8* nonnull %192) #6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(60) %192, i8* noundef nonnull align 1 dereferenceable(60) getelementptr inbounds ([60 x i8], [60 x i8]* @__const.xdp_router_func.____fmt.11, i64 0, i64 0), i64 60, i1 false)
  %193 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %192, i32 60) #6
  call void @llvm.lifetime.end.p0i8(i64 60, i8* nonnull %192) #6
  br label %194

194:                                              ; preds = %168, %156, %144, %93, %77, %130, %74, %104, %44, %39, %19, %181, %190, %170, %191, %32
  %195 = phi i32 [ 2, %170 ], [ 2, %191 ], [ 1, %190 ], [ 2, %181 ], [ 2, %32 ], [ 1, %19 ], [ 1, %39 ], [ 1, %44 ], [ 1, %104 ], [ 1, %130 ], [ 1, %74 ], [ 1, %77 ], [ 1, %93 ], [ 1, %144 ], [ 1, %156 ], [ 2, %168 ]
  %196 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %196)
  store i32 %195, i32* %2, align 4, !tbaa !20
  %197 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %196) #6
  %198 = icmp eq i8* %197, null
  br i1 %198, label %212, label %199

199:                                              ; preds = %194
  %200 = bitcast i8* %197 to i64*
  %201 = load i64, i64* %200, align 8, !tbaa !38
  %202 = add i64 %201, 1
  store i64 %202, i64* %200, align 8, !tbaa !38
  %203 = load i32, i32* %20, align 4, !tbaa !3
  %204 = load i32, i32* %24, align 4, !tbaa !8
  %205 = sub i32 %203, %204
  %206 = zext i32 %205 to i64
  %207 = getelementptr inbounds i8, i8* %197, i64 8
  %208 = bitcast i8* %207 to i64*
  %209 = load i64, i64* %208, align 8, !tbaa !40
  %210 = add i64 %209, %206
  store i64 %210, i64* %208, align 8, !tbaa !40
  %211 = load i32, i32* %2, align 4, !tbaa !20
  br label %212

212:                                              ; preds = %194, %199
  %213 = phi i32 [ %211, %199 ], [ 0, %194 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %196)
  br label %214

214:                                              ; preds = %117, %52, %212
  %215 = phi i32 [ %213, %212 ], [ 0, %52 ], [ 0, %117 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %28) #6
  br label %216

216:                                              ; preds = %1, %214
  %217 = phi i32 [ %215, %214 ], [ 0, %1 ]
  ret i32 %217
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #4

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local i32 @xdp_pass_func(%struct.xdp_md* nocapture readnone %0) #5 section "xdp_pass" {
  ret i32 2
}

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { argmemonly mustprogress nofree nounwind willreturn writeonly }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #4 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{!"Ubuntu clang version 13.0.0-2"}
!3 = !{!4, !5, i64 4}
!4 = !{!"xdp_md", !5, i64 0, !5, i64 4, !5, i64 8, !5, i64 12, !5, i64 16}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{!4, !5, i64 0}
!9 = !{!10, !11, i64 12}
!10 = !{!"ethhdr", !6, i64 0, !6, i64 6, !11, i64 12}
!11 = !{!"short", !6, i64 0}
!12 = !{!13, !6, i64 0}
!13 = !{!"newip_offset", !6, i64 0, !6, i64 1, !6, i64 2}
!14 = !{!4, !5, i64 8}
!15 = !{!16, !6, i64 0}
!16 = !{!"shipping_spec", !6, i64 0, !6, i64 1, !6, i64 2}
!17 = !{!16, !6, i64 1}
!18 = !{!19, !6, i64 0}
!19 = !{!"bpf_fib_lookup", !6, i64 0, !6, i64 1, !11, i64 2, !11, i64 4, !11, i64 6, !5, i64 8, !6, i64 12, !6, i64 16, !6, i64 32, !11, i64 48, !11, i64 50, !6, i64 52, !6, i64 58}
!20 = !{!5, !5, i64 0}
!21 = !{!6, !6, i64 0}
!22 = !{i64 0, i64 16, !21, i64 0, i64 16, !21, i64 0, i64 16, !21}
!23 = !{!24, !5, i64 0}
!24 = !{!"meta_info", !5, i64 0, !25, i64 4}
!25 = !{!"max_delay_forwarding", !11, i64 0, !11, i64 2, !11, i64 4}
!26 = !{!13, !6, i64 1}
!27 = !{!13, !6, i64 2}
!28 = !{!11, !11, i64 0}
!29 = !{!30, !11, i64 4}
!30 = !{!"ping_contract", !11, i64 0, !11, i64 2, !11, i64 4, !31, i64 8}
!31 = !{!"long long", !6, i64 0}
!32 = !{!25, !11, i64 2}
!33 = !{!24, !11, i64 6}
!34 = !{!25, !11, i64 4}
!35 = !{!24, !11, i64 8}
!36 = !{!4, !5, i64 12}
!37 = !{!19, !5, i64 8}
!38 = !{!39, !31, i64 0}
!39 = !{!"datarec", !31, i64 0, !31, i64 8}
!40 = !{!39, !31, i64 8}
