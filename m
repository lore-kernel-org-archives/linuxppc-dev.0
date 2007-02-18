Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 44277DDE35
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:17:08 +1100 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id E949E902247
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:04 +0000 (UTC)
Received: from mail54-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id DDA12280050
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:04 +0000 (UTC)
Received: from mail54-sin (localhost.localdomain [127.0.0.1])
	by mail54-sin-R.bigfish.com (Postfix) with ESMTP id A91E383834A
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:04 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail54-sin.bigfish.com (Postfix) with ESMTP id 152B5830059
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:03 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id l1I1H0HN017304
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:01 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l1I1H0PY001200
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:00 GMT
Message-ID: <45D7A90B.4020706@am.sony.com>
Date: Sat, 17 Feb 2007 17:16:59 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC 1/3] zImage: Add signed types
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add signed types to the powerpc zImage bootwrapper. These are needed by the
PS3 hcall interface.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
These are some generic zImage routines I have from my PS3 bootwrapper work.
Comments welcome.

-Geoff

 arch/powerpc/boot/types.h |    4 ++++
 1 files changed, 4 insertions(+)

--- ps3-linux-dev.orig/arch/powerpc/boot/types.h
+++ ps3-linux-dev/arch/powerpc/boot/types.h
@@ -7,6 +7,10 @@ typedef unsigned char		u8;
 typedef unsigned short		u16;
 typedef unsigned int		u32;
 typedef unsigned long long	u64;
+typedef signed char		s8;
+typedef short			s16;
+typedef int			s32;
+typedef long long		s64;
 
 #define min(x,y) ({ \
 	typeof(x) _x = (x);	\
