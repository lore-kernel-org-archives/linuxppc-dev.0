Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 49D6C2BF34
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Nov 2004 19:53:20 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id iA98sQdm008021
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 Nov 2004 10:54:27 +0200 (EET)
Message-ID: <4190840D.6000403@intracom.gr>
Date: Tue, 09 Nov 2004 10:47:09 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: The case of the disappearing CPU_FTR_xxx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

I'm currently trying to implement proper idling for 8xx in 2.4 (please 
don't bitch yet
since things are pretty similar for 2.6 too).

It appears that the flags set in cputable.c, i.e. CPU_FTR_NAP get cleared
at some point in the init sequence.

Looking at the 6xx idle code, there is some extra handling for that case but
I'm unable to locate what is going on.

Can anyone shed some light on the issue?

Regards

Pantelis
