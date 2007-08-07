Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1617CDDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 04:39:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IITxq-0002IR-9o
	for linuxppc-embedded@ozlabs.org; Tue, 07 Aug 2007 11:39:30 -0700
Message-ID: <12039968.post@talk.nabble.com>
Date: Tue, 7 Aug 2007 11:39:30 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: BusyBox passwd requires root privileges
In-Reply-To: <46B3A44E.1030508@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11990563.post@talk.nabble.com> <46B395B5.1040009@freescale.com>
	<11991239.post@talk.nabble.com> <46B3A44E.1030508@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Scott Wood-2 wrote:
> 
> 
> Make sure it's owned by root, and chmod 4755 the binary.  I'm not sure 
> how to go about telling busybox to drop suid when invoked as something 
> else.  It'd probably be better to build two busyboxes, one with all suid 
> commands and the other with the rest.
> 
> -Scott
> 
> 
I chmod 4755 to the passwd binary and it worked.  Before I did that I also
added a Busybox.conf file in /etc with this in it...
[SUID]
passwd = ssx root.root

I don't know if I needed that or not but it works now. Thanks
-- 
View this message in context: http://www.nabble.com/BusyBox-passwd-requires-root-privileges-tf4214675.html#a12039968
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
