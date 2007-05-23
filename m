Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2AC75DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 19:47:09 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id 376C8108789
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 11:41:32 +0200 (CEST)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 11991-01-22 for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 11:41:31 +0200 (CEST)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id 8580A10834E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 11:41:28 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: HIGHMEM on 440EPx board with 1GB of RAM
Date: Wed, 23 May 2007 11:41:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705231141.18614.matthias.fuchs@esd-electronics.com>
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

I ran into some trouble with a custom 440EPx board that uses 1GB of RAM 
(SO-DIMM module). The board and kernel port is very identical to the AMCC 
sequoia board.
The kernel (recent version from Denx 2.6 repository) is configured with 
HIGHMEM support.

The most obvious problems are crashes when accessing yaffs2 partitions on NAND 
flashes. This seems to be no NAND or yaffs filesystem issue.

My problems dissapear when passing the mem= kernel parameter with mem=768M. 

In general the system is stable with the full gig of ram and e.g. not using 
yaffs. So I do not believe in a hardware issue.

Can anybody give me a hint where I should start to investigate ?

Matthias
