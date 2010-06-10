Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BC764B7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 19:25:47 +1000 (EST)
Message-ID: <4C10AF92.9060400@grandegger.com>
Date: Thu, 10 Jun 2010 11:25:38 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: CAN Subsystem and MPC52xx onboard controller
References: <201006101041.27926.roman.fietze@telemotive.de>
In-Reply-To: <201006101041.27926.roman.fietze@telemotive.de>
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

On 06/10/2010 10:41 AM, Roman Fietze wrote:
> Hello List Members,
> 
> I have tried multiple versions/branches and git repos (torvalds,
> benh/{next,master}, denx, pengutronix, ...) to get a 2.6.34 or HEAD
> version of that repos that compiles w/o errors when the CAN subsystem
> is enabled and the MPC5xxx onboard driver is selected starting with
> the lite5200b_defconfig.
> 
> Until now I'm out of luck. If other's also have compile problems I can
> of course offer to try to dig into the sources.

Hm, kernel.org's "linux-2.6.34.tar.bz2" builds here just fine with
lite5200b_defconfig and Socket-CAN support enabled for the MSCAN. I can
imaging that there are issues with more recent "-rc" versions due to
Grant's OF platform device generalization. Also the DTS entries entries
for MSCAN in lite5200b.dts seem OK.

> Q0:
> 
> I'm somewhat unsure what repos to use in general to develop using the
> 2.6 on a Lite5200B compatible board (for the 2.4 we always used the
> DENX repos).

Please use the mainline kernel for that board.

Wolfgang.
