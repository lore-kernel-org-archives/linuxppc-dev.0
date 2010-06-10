Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1D2E6B7D6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 19:37:50 +1000 (EST)
Message-ID: <4C10B266.3070601@grandegger.com>
Date: Thu, 10 Jun 2010 11:37:42 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: CAN Subsystem and MPC52xx onboard controller
References: <201006101041.27926.roman.fietze@telemotive.de>	<20100610085923.GE5333@pengutronix.de>
	<201006101129.15581.roman.fietze@telemotive.de>
In-Reply-To: <201006101129.15581.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2010 11:29 AM, Roman Fietze wrote:
> Hello Wolfram,
> 
> On Thursday 10 June 2010 10:59:23 Wolfram Sang wrote:
> 
>> The mainline kernel works fine here with Phytec based MPC5xxx-boards.
> 
> Reading your answer made me hope again, and I just pulled the newest
> HEAD from the mainline kernel and tried it once more. Now it compiles.
> Thanks for retriggering me again.
> 
> All the other's sill have problems, except pengutronix, most of them
> with an inconsistency (with the socket CAN files?), which shows up as
> 
>   'struct can_bittime_std' declared inside parameter list
> 
> in net/can/dev.c:69

With all other you mean the linux-2.6-denx tree!? These seem to be some
reminders of the old Socket-CAN support merged into that tree (master
branch). I will clean that up a.s.a.p. Nevertheless, whenever possible,
you should use the mainline kernel.

> So I assume we will switch to the mainline kernel, which we already
> use for Atom based x86 development on the MEN boards.

DENX tries to push patches upstream as fast as possible and new projects
are usually based on the mainline kernel tree.

Wolfgang.


> 
> Thanks once more
> 
> Roman
> 
