Return-Path: <Gehirnmann@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9E78A67A59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 17:50:47 +1000 (EST)
Date: Thu, 12 May 2005 09:50:46 +0200 (MEST)
From: "Peter Gehirnforce" <Gehirnmann@gmx.de>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <25943.1115884246@www45.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: ELDK/DENX linking fails for <iostream>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

when I try to link (after successful compile), I get the following type of
errors (for example):
...
undefined reference to 'std::allocator<char>::allocator[in-charge]()'
...
undefined reference to '__cxa_allocate_exception'
...
Can someone explain what happens?

thx
Peter

-- 
+++ Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS +++
GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail
