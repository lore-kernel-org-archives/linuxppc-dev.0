Return-Path: <a.korud@vector.com.pl>
Received: from lion.vector.com.pl (lion.vector.com.pl [81.210.9.36])
	by ozlabs.org (Postfix) with ESMTP id 88B672BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 03:31:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Date: Thu, 25 Nov 2004 17:18:49 +0100
Message-ID: <1101402827.10369.8.camel@localhost>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GP "Ebony" boot problems
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
I'm trying to boot original 440GP "Ebony" board wiath original IBM ROM
Monitor:
...
	440GP 1.18 ROM Monitor (02/11/02)
...

However I've discovered that it requires special image in KDI (Kernel
Downloadable Image) format. And it seems that the only way to make such
image is to use 'mkimage' utility from LynuxWorks which is not widely
available :-)
Can anybody help me with this?

thanks in advance,

--

Andriy Korud

P.S. For some reason I cannot replace ROM Monitor with U-Boot on this
board.
