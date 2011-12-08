Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id EEDD01007D7
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 22:15:14 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id CEEC4186DEC0
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 12:15:02 +0100 (CET)
Received: from igel.home (ppp-88-217-121-66.dynamic.mnet-online.de
 [88.217.121.66])
 by mail.mnet-online.de (Postfix) with ESMTPA id 52E9E1C00111
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 12:15:02 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: cpu idle time going backward
Date: Thu, 08 Dec 2011 12:15:01 +0100
Message-ID: <m2fwgvnwlm.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There seems to be something wrong with cpu idle time accounting at least
on G5.  The value as reported in the cpu lines in /proc/stat seems to be
stuck in the interval [100000,210000] for each cpu, jumping back at
random points.  Any idea what could be the problem?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
