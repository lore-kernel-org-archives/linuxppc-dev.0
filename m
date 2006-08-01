Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49D5F67B5E
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 02:39:35 +1000 (EST)
In-Reply-To: <200608010838.08139.david-b@pacbell.net>
References: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
	<93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
	<200608010838.08139.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A5CCE58-CF92-4655-A224-8D79B43F49F4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
Date: Tue, 1 Aug 2006 11:39:27 -0500
To: David Brownell <david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net,
	gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2006, at 10:38 AM, David Brownell wrote:

> On Thursday 20 July 2006 5:59 am, Kumar Gala wrote:
>
>>>
>>> -#ifdef CONFIG_PPC_83xx
>>> +#ifdef CONFIG_MPC834x
>
> So at the end of all that discussion, was there a USB patch to merge?
> If so, I don't see one in my mail folder.

Not on this side of things.  If we clean up the CONFIG_PPC stuff I'll  
push that through the PPC maintainer.  There was a patch for gadget  
support for the controller, but not sure if you handle that or not.

- k
