Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 14746689A4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 21:32:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 5 Jan 2006 11:03:15 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2F49@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Brett McNerney" <mcnernbm@notes.udayton.edu>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: mmap
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Brett McNerney wrote:
[...]
>I am open for other options on how I can do this other then mmap.  And
am still not against a driver >built into the kernel if someone has a an
example I could see and can explain how to add it in so it >builds into
the kernel since I have had no success on that either and have tried a
couple different >tutorials I found online with no success.

Ah, this is the first one of 2006. Happy new year!
Your question is a linuxppc-embedded FAQ, coming at least every 3 months
here.
It is documented in Denx's FAQ[1], and accessible through shorter
URL[2].
For more information, please follow this thread[3] (not ppc specific
actually).
A good book of C language about what are pointers and how scanf works
might=20
help too in case of confusion :-)

[1]
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
[2] http://tinyurl.com/6c7th
[3] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html

Regards,
--=20
Stephane
