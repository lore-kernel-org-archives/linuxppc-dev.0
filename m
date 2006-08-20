Return-Path: <dtutty@porchlight.ca>
Received: from tor-pinab.porchlight.ca (tor-pinab.porchlight.ca
	[209.171.52.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1379567B9F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 03:21:01 +1000 (EST)
Received: from keep.hooton (tor-ppp-209.29.44.101.porchlight.ca
	[209.29.44.101]) (authenticated bits=0)
	by tor-pinab.porchlight.ca (8.13.1/8.13.1) with ESMTP id k7KH0xOc021553
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 13:01:00 -0400
Received: from dtutty by keep.hooton with local (Exim 4.50) id 1GEqfR-0002Ks-5e
	for linuxppc-dev@ozlabs.org; Sun, 20 Aug 2006 13:00:57 -0400
Date: Sun, 20 Aug 2006 13:00:56 -0400
From: dtutty@porchlight.ca
To: linuxppc-dev@ozlabs.org
Subject: boot problems on pseries
Message-ID: <20060820170055.GA8958@hooton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm switching from an IBM 486 and purchasing an IBM H50 (7026-H50), so
I'm new to the PPC.  My vendor wants to ensure that it boots linux
before he ships it.  I burned and sent him a few different distro CDs to
try and none boot.  We can get yaboot to boot then get stuck at the
yaboot command line and can't get futher.  As a fall-back, I was hoping
to use OF to boot the kernel directly and get a kernel-panic when it
can't find init but we can't get that far either.  The error message
'claim failed' is returned immediatly with no indication that the kernel
tried to start.

I'm told by several people that the H50 is the same as the F50 in a
different format and that the F50 is known to work.  Since the task at
hand is to get any linux to boot and not to actually install linux, I
need a kernel that will boot.  Even a simple boot-floppy set would be
great.  

Does anyone have a link to a boot/root floppy set that will work?

Hardware details:  IBM 7026-H50, 256 MB ram, dual PPC 604e 332 MHz, 9.1
GB HD in Bay 2, standard CD-ROM, PowerGXT130P graphics accelerator.

Thanks,
Doug.
