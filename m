Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCBB3DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:20:59 +1100 (EST)
In-Reply-To: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
References: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7F96CD5-4CB7-48E3-ABF5-17E1685AAC24@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: USB Host controller for MPC8548e board
Date: Tue, 13 Feb 2007 19:19:57 -0600
To: Michael Kelly <mike@cogcomp.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2007, at 6:21 PM, Michael Kelly wrote:

> Hello all.  We are in the process of designing an MPC8548e board.  We
> wish to add
> USB host via either the NXP ISP1561 or NEC upd720101.  They are  
> both OHCI and
> EHCI.

Haven't worked with either of this, you're probably better asking  
about this on the linux-usb list.

> Is there any general advice on one over the other or even if it is
> realistic to have a USB
> host controller on a big endian processor?

There shouldn't be any issue with having a USB controller on a big- 
endian processor.

If your connecting them over PCI it should pretty easy to get them up  
and running.

- k
