Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B90BDDF11
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 07:04:17 +1000 (EST)
Message-Id: <03B2C90C-D07D-4EE0-BBF2-3210E2FF781A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <482CA47C.1020403@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to powerpc.git powerpc-next branch
Date: Thu, 15 May 2008 16:04:09 -0500
References: <18475.30315.579805.168910@cargo.ozlabs.ibm.com>
	<482CA47C.1020403@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2008, at 4:00 PM, Timur Tabi wrote:

> Paul Mackerras wrote:
>> I have added the following patches to the powerpc-next and master
>> branches of the powerpc.git repository.  This includes commits pulled
>> from Kumar's tree.
>
> What about these:
>
> [PATCH] Add null pointer check to of_find_property

That's up to paul.

> [PATCH v2] Update defconfig for MPC8610 HPCD

I'm hold this one off until we update all the defconfigs.

- k
