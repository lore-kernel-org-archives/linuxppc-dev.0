Return-Path: <Thomas.Hommel@gefanuc.com>
Received: from ext-ch1gw-6.online-age.net (ext-ch1gw-6.online-age.net
	[64.37.194.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 09548DDEF1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 01:32:39 +1000 (EST)
Received: from int-ch1gw-3.online-age.net (int-ch1gw-3 [3.159.232.67])
	by ext-ch1gw-6.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id m4KF77pY001278
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 11:07:07 -0400
Received: from ALPMLEF02.e2k.ad.ge.com (int-ch1gw-3 [3.159.232.67])
	by int-ch1gw-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m4KF75Dr024204
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 11:07:06 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Configuring virtual memory layout
Date: Tue, 20 May 2008 17:06:34 +0200
Message-ID: <62DDBB9E5E23CC4A929EE46F9427CEAFB11319@BUDMLVEM04.e2k.ad.ge.com>
From: "Hommel, Thomas (GE EntSol,
	Intelligent Platforms)" <Thomas.Hommel@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I am trying to figure out how to configure the virtual memory layout in
the kernel.
To increase the size of the Vmalloc area, I have set KERNEL_START to
0xa0000000 and have left LOWMEM_SIZE at 0x30000000. The other parameters
in 'Advanced setup' are unchanged.
This works fine with 512 MB of RAM. However, with 1 GB of RAM installed,
the system shows odd behavior, crashes, faults, ... This seems to be due
to the fact that it then uses 256 MB of high memory.

I played around with HIGHMEM_START, but couldn't get a working setting.

How do these parameters have to be configured correctly? Is there any
documentation for that?

Thanks for your help
Thomas
