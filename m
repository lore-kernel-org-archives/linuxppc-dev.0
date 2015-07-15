Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B141A0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:03:08 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 21:03:06 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 10F7F19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:54:03 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t6F30VSv15794398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:00:31 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F332ZZ026578
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:03:03 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 1/8] powerpc/perf/hv-24x7: Whitespace - fix parameter
 alignment
Date: Tue, 14 Jul 2015 20:01:48 -0700
Message-Id: <1436929315-28520-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix parameter alignment to be consistent with coding style.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index df95629..9d73c69 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -416,7 +416,7 @@ out_val:
 }
 
 static struct attribute *event_to_desc_attr(struct hv_24x7_event_data *event,
-				int nonce)
+					    int nonce)
 {
 	int nl, dl;
 	char *name = event_name(event, &nl);
@@ -444,7 +444,7 @@ event_to_long_desc_attr(struct hv_24x7_event_data *event, int nonce)
 }
 
 static ssize_t event_data_to_attrs(unsigned ix, struct attribute **attrs,
-		struct hv_24x7_event_data *event, int nonce)
+				   struct hv_24x7_event_data *event, int nonce)
 {
 	unsigned i;
 
@@ -512,7 +512,7 @@ static int memord(const void *d1, size_t s1, const void *d2, size_t s2)
 }
 
 static int ev_uniq_ord(const void *v1, size_t s1, unsigned d1, const void *v2,
-					size_t s2, unsigned d2)
+		       size_t s2, unsigned d2)
 {
 	int r = memord(v1, s1, v2, s2);
 
@@ -526,7 +526,7 @@ static int ev_uniq_ord(const void *v1, size_t s1, unsigned d1, const void *v2,
 }
 
 static int event_uniq_add(struct rb_root *root, const char *name, int nl,
-				unsigned domain)
+			  unsigned domain)
 {
 	struct rb_node **new = &(root->rb_node), *parent = NULL;
 	struct event_uniq *data;
@@ -650,8 +650,8 @@ static ssize_t catalog_event_len_validate(struct hv_24x7_event_data *event,
 #define MAX_4K (SIZE_MAX / 4096)
 
 static int create_events_from_catalog(struct attribute ***events_,
-		struct attribute ***event_descs_,
-		struct attribute ***event_long_descs_)
+				      struct attribute ***event_descs_,
+				      struct attribute ***event_long_descs_)
 {
 	unsigned long hret;
 	size_t catalog_len, catalog_page_len, event_entry_count,
@@ -1008,8 +1008,8 @@ static const struct attribute_group *attr_groups[] = {
 };
 
 static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
-			struct hv_24x7_data_result_buffer *result_buffer,
-			unsigned long ret)
+			   struct hv_24x7_data_result_buffer *result_buffer,
+			   unsigned long ret)
 {
 	struct hv_24x7_request *req;
 
@@ -1026,7 +1026,7 @@ static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
  * Start the process for a new H_GET_24x7_DATA hcall.
  */
 static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
-			struct hv_24x7_data_result_buffer *result_buffer)
+			      struct hv_24x7_data_result_buffer *result_buffer)
 {
 
 	memset(request_buffer, 0, 4096);
@@ -1041,7 +1041,7 @@ static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
  * by 'init_24x7_request()' and 'add_event_to_24x7_request()'.
  */
 static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
-			struct hv_24x7_data_result_buffer *result_buffer)
+			     struct hv_24x7_data_result_buffer *result_buffer)
 {
 	unsigned long ret;
 
-- 
1.7.9.5
