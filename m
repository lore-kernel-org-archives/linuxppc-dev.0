Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C70A2DDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:29:53 +1000 (EST)
Message-ID: <46A8BDE1.8080900@freescale.com>
Date: Thu, 26 Jul 2007 10:29:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: About mdio_bus for 82xx based board
References: <op.tv0x7yvmnhx3hy@phoenix>
	<20070725162305.GA26276@ld0162-tx32.am.freescale.net>
	<op.tv2in7f5nhx3hy@phoenix> <op.tv2kmbgqnhx3hy@phoenix>
	<op.tv2nbmkonhx3hy@phoenix>
In-Reply-To: <op.tv2nbmkonhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> Well, I've downloaded the latest git from Paul's tree, and some patches  
> still fail (and the mpc8272_ads config doesn't compile). Must I get 
> some  other revision of the tree (if yes, how's that done in git - my 
> first time  with it )

They don't apply on top of Paul's current tree -- they apply to his tree 
as of the time the patchset was posted.  I should have a revised 
patchset in a week or two (the delay mainly being to add and test a 
couple new boards).

-Scott
