Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 3E6142BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 00:27:51 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i9TESueh007923
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 17:28:57 +0300 (EEST)
Message-ID: <4182524A.3010806@intracom.gr>
Date: Fri, 29 Oct 2004 17:23:06 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <JPEALJAFNGDDLOPNDIEEEEMOCNAA.joakim.tjernlund@lumentis.se>
	<41823D68.1090100@intracom.gr>
	<20041029142209.GN2097@smtp.west.cox.net>
In-Reply-To: <20041029142209.GN2097@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

[snip]

>In 2.6.10-rc1 release? No.  In linuxppc-2.5? Now, yes.  The changes came
>from Randy Vinson, to make request_irq() / openpic_hookup_cascade()
>calls become arch_initcalls() which fixed at least some platforms.  I
>would guess 8xx will need something similar.
>
>  
>
In linuxppc-2.5 yes.

Just trying to catch up after my small period of absence...

Regards

Pantelis
