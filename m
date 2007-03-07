Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 0B639DDED2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 09:41:06 +1100 (EST)
Date: Wed, 7 Mar 2007 23:41:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [2.6 patch] drivers/macintosh/mac_hid.c: make code static
Message-ID: <20070307224107.GC3441@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Feb 2007

 drivers/macintosh/mac_hid.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.20-rc6-mm3/drivers/macintosh/mac_hid.c.old	2007-02-06 07:38:21.000000000 +0100
+++ linux-2.6.20-rc6-mm3/drivers/macintosh/mac_hid.c	2007-02-06 07:39:14.000000000 +0100
@@ -24,7 +24,7 @@
 
 #if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
-ctl_table mac_hid_files[] = {
+static ctl_table mac_hid_files[] = {
 	{
 		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON_EMULATION,
 		.procname	= "mouse_button_emulation",
@@ -53,7 +53,7 @@
 };
 
 /* dir in /proc/sys/dev */
-ctl_table mac_hid_dir[] = {
+static ctl_table mac_hid_dir[] = {
 	{
 		.ctl_name	= DEV_MAC_HID,
 		.procname	= "mac_hid",
@@ -65,7 +65,7 @@
 };
 
 /* /proc/sys/dev itself, in case that is not there yet */
-ctl_table mac_hid_root_dir[] = {
+static ctl_table mac_hid_root_dir[] = {
 	{
 		.ctl_name	= CTL_DEV,
 		.procname	= "dev",
@@ -129,7 +129,7 @@
 	return ret;
 }
 
-int __init mac_hid_init(void)
+static int __init mac_hid_init(void)
 {
 	int err;
 
