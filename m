Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 88C4967A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 00:51:40 +1000 (EST)
Received: from smtprelay.indy.tce.com (ismtprelay.indy.tce.com
	[157.254.96.114])
	by dmzraw2.extranet.tce.com (8.12.5/8.12.5) with ESMTP id
	j3EEpclh017620
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Apr 2005 14:51:38 GMT
Received: from boulsmailbh02.eu.thmulti.com (localhost [127.0.0.1])
	by smtprelay.indy.tce.com (8.9.3/8.9.1) with ESMTP id OAA06987
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Apr 2005 14:51:37 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 14 Apr 2005 16:51:16 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D47@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: =?iso-8859-1?q?RE=3A_R=E9f=2E_=3A_Re=3A_R=E9f=2E_=3A_RE=3A_mmap_?=
	=?iso-8859-1?q?=3A_please_help__!?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sophie CARAYOL wrote:
>But, the real question is : if you use the /dev/mem (with open() and =
mmap
>()), could you use, in the user space, the pointer returned by the mmap
>function to access the physical memory or do you have to use read/write =
(on
>the file descriptor) to access physical memory because i haven't the =
same
>results according to the used method.

The read/write method is a heavy weight method, while the pointer =
returned by mmap is light and very efficient way in user-space, and It =
just works(tm).

Have you made sure the read/write is bypassing caching/speculative mode?
Can some timing issues explain the difference? Are you reading/writing=20
the right number of bytes?
Can you check both methods on a ReadOnly hardware register, with a known
value to be read?

>Thanks for 'od' but i haven't in my packages.

Anything else from dd with hexdump to your own built peek & poke?
What about mempoke from Conor McLoughlin?
http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015871.html


Regards,
--=20
Stephane
