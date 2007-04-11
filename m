Return-Path: <MBenedict@twacs.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3EAA5DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 06:59:36 +1000 (EST)
Received: from outbound2-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-fra-R.bigfish.com (Postfix) with ESMTP id A086A5E1359
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 20:59:32 +0000 (UTC)
Received: from mail29-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound2-fra.bigfish.com (Postfix) with ESMTP id 9F104738058
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 20:59:32 +0000 (UTC)
Received: from mail29-fra (localhost.localdomain [127.0.0.1])
	by mail29-fra-R.bigfish.com (Postfix) with ESMTP id 92D2C37823E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 20:59:32 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail29-fra.bigfish.com (Postfix) with ESMTP id 0C292AF0071
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 20:59:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Still trying to get a stable 2.6.20.4 running on 8349ITX eval
	board
Date: Wed, 11 Apr 2007 15:59:11 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795DD@twx-exch01.twacs.local>
In-Reply-To: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
References: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I've tried passing "init=3D/bin/sh" on the command line and I=20
>can reach a sh=20
>prompt, but it doesn't take long before it locks up.  I can do=20
>a "find .=20
>-name '*gcc*'" about four times before it stops.=20

I, too, am still experiencing this issue.   If it helps debugging, it is
only VFS accesses that seem to be locked.  I was able to run a
network-based IO app fine for almost a day (I rebooted the machine
then), even though the root filesystem "stops".

>2) I assume someone (Kumar?) has gotten some combination of=20
>kernel/FS to=20
>boot and run on this box.  What combination is that?

I am thinking that these issues are closely coupled to root NFS.  I know
this isn't good news, but I think the combo is running the root
filesystem on the hard drive or ramdisk.
	Good luck,
		Michael
