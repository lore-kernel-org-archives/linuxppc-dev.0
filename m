Return-Path: <dibacco@inwind.it>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by ozlabs.org (Postfix) with ESMTP id 9BFA167B34
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:00:52 +1100 (EST)
Received: from localhost (172.16.1.203) by smtp2.libero.it (7.0.027-DD01)
	id 43E202BB00BFB950 for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 00:00:50 +0100
Received: from smtp0.libero.it ([172.16.1.204])
	by localhost (asav17.libero.it [193.70.193.4]) (amavisd-new, port 10024)
	with ESMTP id 27317-07-3 for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 00:00:49 +0100 (CET)
Received: from libero.it (172.16.1.219) by smtp0.libero.it (7.0.027-DD01)
	id 439064B400B32F2F for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 00:00:49 +0100
Date: Sat, 11 Feb 2006 00:00:49 +0100
Message-Id: <IUHULD$E8FF06F7D3BACC0D72A90B39E3254D5F@libero.it>
Subject: denx 2.4 kernel doesn't compile amd_flash.c
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
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

I downloaded denx 2.4 kernel via cvs. I tried to compile it for a MBX boa=
rd but I get the following problem:

amd_flash.c:143: error: structure has no member named `buswidth'


I was successful using the kernel included in ELDK 3.1.1.

Someone could help?
