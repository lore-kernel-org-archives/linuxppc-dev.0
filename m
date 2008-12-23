Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 4B2FEDDD1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Dec 2008 11:52:15 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEvVI-0001eN-FS
	for linuxppc-embedded@ozlabs.org; Tue, 23 Dec 2008 00:52:08 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Dec 2008 00:52:08 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Dec 2008 00:52:08 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
Date: Tue, 23 Dec 2008 00:52:01 +0000 (UTC)
Message-ID: <loom.20081223T003725-939@post.gmane.org>
References: <loom.20081219T062005-806@post.gmane.org>
	<494BFE2B.2010103@freescale.com>
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
> cuboot-824x is for 8240, 8245, and similar chips.  You want cuboot-pq2.

Hi Scott et al,

I seem to get further with the cuboot-824x file- with the cuboot-pq2 file the 
boot sequence doesn't even reach the 'zImage starting' stage. The machine 
reboots just before it should be printing out 'zImage starting'. 

Is there a way I can get more detailed debug to see what's happening?

Do settings from bd_info struct override the settings from the DTS file?

Also, a lot of the settings passed from u-boot in our 2.6.14 environment are 
plain wrong eg. wrong memory, wrong processor speed. In this case, the correct 
settings are set elsewhere (for memory, it is a kernel parameter ie. mem=32M, 
and the processor speed is set in the 2.6.14 'make menuconfig'). Therefore, 
the machine still boots into Linux correctly. For 2.6.27, would these 
incorrect settings be causing my problems?

Daniel
