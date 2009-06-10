Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0072B71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:27 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 30/33] ps3: Switch ps3_os_area_[gs]et_rtc_diff to
	EXPORT_SYMBOL_GPL()
Date: Wed, 10 Jun 2009 16:39:05 +0200
Message-Id: <1244644748-24211-31-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-30-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-29-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-30-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They were never intended to be exported using EXPORT_SYMBOL() anyway

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index cf1cd0f..6e4125d 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -808,7 +808,7 @@ u64 ps3_os_area_get_rtc_diff(void)
 {
 	return saved_params.rtc_diff;
 }
-EXPORT_SYMBOL(ps3_os_area_get_rtc_diff);
+EXPORT_SYMBOL_GPL(ps3_os_area_get_rtc_diff);
 
 /**
  * ps3_os_area_set_rtc_diff - Set the rtc diff value.
@@ -824,7 +824,7 @@ void ps3_os_area_set_rtc_diff(u64 rtc_diff)
 		os_area_queue_work();
 	}
 }
-EXPORT_SYMBOL(ps3_os_area_set_rtc_diff);
+EXPORT_SYMBOL_GPL(ps3_os_area_set_rtc_diff);
 
 /**
  * ps3_os_area_get_av_multi_out - Returns the default video mode.
-- 
1.6.2.4
