Return-Path: <pratyush.anand@st.com>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A4A8B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:26:36 +1000 (EST)
From: Pratyush Anand <pratyush.anand@st.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH 12/14] include/linux/usb/gadget.h : include <linux/device.h>
	for successful compilation
Date: Tue, 30 Aug 2011 17:27:59 +0530
Message-ID: <171f829cad0bfa86b79ae74e9c6c9ae4eefb2738.1314704558.git.pratyush.anand@st.com>
In-Reply-To: <cover.1314704557.git.pratyush.anand@st.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gadget.h uses struct device, which has been declared in linux/device.h. So it
must be included.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 include/linux/usb/gadget.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 006412c..32f7b69 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -16,6 +16,7 @@
 #define __LINUX_USB_GADGET_H
 
 #include <linux/slab.h>
+#include <linux/device.h>
 
 struct usb_ep;
 
-- 
1.7.2.2
