Return-Path: <wladislav.kw@gmail.com>
Received: from mail-bk0-x22e.google.com (mail-bk0-x22e.google.com
 [IPv6:2a00:1450:4008:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E1302C0167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 19:41:46 +1000 (EST)
Received: by mail-bk0-f46.google.com with SMTP id 6so3405949bkj.19
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 02:41:39 -0700 (PDT)
Message-ID: <52303A6A.2050702@gmail.com>
Date: Wed, 11 Sep 2013 11:39:54 +0200
From: Wladislav Wiebe <wladislav.kw@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PPC: set default date on PPC without RTC
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello guys,

would like to ask if there is a proper possibility on PPC to
set default date (basically the year). The board has no RTC chip,
and I would need instead of 1970 another year.

For some reason does e.g:
--- a/linux/arch/powerpc/kernel/time.c
+++ b/linux/arch/powerpc/kernel/time.c
@@ -1099,7 +1099,7 @@ void __init time_init(void)


 #define FEBRUARY       2
-#define        STARTOFTIME     1970
+#define        STARTOFTIME     2013
 #define SECDAY         86400L
 #define SECYR          (SECDAY * 365)
 #define        leapyear(year)          ((year) % 4 == 0 && \


not work to me. Is there also another place which should be changed?
(I know it can be changed from userspace also, but I would need it before userspace)


Thanks and BR,
Wladislav Wiebe
