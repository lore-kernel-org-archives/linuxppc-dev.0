Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 96DADDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Dec 2008 10:22:21 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LFGZn-0004ZR-0Q
	for linuxppc-embedded@ozlabs.org; Tue, 23 Dec 2008 23:22:12 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Dec 2008 23:22:11 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Dec 2008 23:22:11 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
Date: Tue, 23 Dec 2008 23:21:57 +0000 (UTC)
Message-ID: <loom.20081223T232059-383@post.gmane.org>
References: <loom.20081219T062005-806@post.gmane.org>	<494BFE2B.2010103@freescale.com>
	<loom.20081223T003725-939@post.gmane.org>
	<49510D2A.4010906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood <at> freescale.com> writes:
> Yes, if u-boot is providing junk, then you'll probably want to hack up 
> the wrapper to ignore it.  Or just upgrade u-boot to one that works. 
> 

Thanks for your advice Scott. Looks like upgrading u-boot will be the easiest 
way forward.
