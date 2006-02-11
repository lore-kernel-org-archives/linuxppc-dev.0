Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F5AD67B49
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 17:09:03 +1100 (EST)
Message-ID: <43ED7EE9.8040501@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 22:06:33 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de><43EBD715.4020303@ovro.caltech.edu>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
	<001701c62e6c$09c48ea0$6401a8c0@CHUCK2>
In-Reply-To: <001701c62e6c$09c48ea0$6401a8c0@CHUCK2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mark,

> I'm currently working on an MPC8247 based design, btw.
> It has a PC104+ header and is directly connected to a
> T.I. 6205 (which, at $10, is a lot of crunch for the buck).

I took a look at the MPC8727 family.

The CPM runs at 200MHz max, and the SSCs can clock at
1/4 that, so only 50MHz; 50MHz/8-bits = 6MB/s.
They're too slow to move 132MB/s.

There is only two external buses too, and no
external bus to memory DMA, since they are the
same bus.

Also, the MPC834x series exists, and beats it out
performance wise.

Thanks for the pointer though!

Dave
