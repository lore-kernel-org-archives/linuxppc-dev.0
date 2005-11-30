Return-Path: <gnemas@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.195])
	by ozlabs.org (Postfix) with ESMTP id 9C6B26884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 21:12:32 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so222329wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 02:12:30 -0800 (PST)
Message-ID: <8e84e0f20511300212n2cb588aevafc08aa4b82c83c0@mail.gmail.com>
Date: Wed, 30 Nov 2005 05:12:30 -0500
From: Gregg Nemas <gnemas@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Setting IDE mode to PIO for compact flash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a compact flash connected to a PPC440GP processor in "true IDE"
mode. The DMA signals are not connected, so the device must be used in
PIO mode.

However, when I issue hdparm -i, it indicates that the current mode is
DMA mode mdma2, and I think this must be why I am getting "lost
interrupt" messages. Unfortunately, when I try to set the mode to PIO
using "hdparm -p1" or "hdparm -X9", it seems to have no effect.

What do I need to do to get the drive to be set to use PIO?

I amusing linux 2.6.12.3.

Thanks.

Gregg
