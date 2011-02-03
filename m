Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id 7E85DB70E9
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2011 05:48:03 +1100 (EST)
Message-ID: <4D4AF861.2050605@mlbassoc.com>
Date: Thu, 03 Feb 2011 11:48:01 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: MMC on MPC8379
References: <4D4717AD.2040905@mlbassoc.com>
In-Reply-To: <4D4717AD.2040905@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2011 01:12 PM, Gary Thomas wrote:
> I'm running 2.6.32 on MPC8379, trying to use the SDHCI interface.
> It seems to work, reads are fine, but when I write to the device
> (I've tried both eMMC soldered-on and pluggable MMC/SD cards),
> I get intermittent failures. Specifically, some blocks will be
> written while others fail. I haven't yet found a pattern.
>
> Is there anything special about this interface? I notice that
> it's not really used by any FSL platforms although the driver
> claims support.

On the surface, it looks like it should work and I'm perplexed
by the failures.

Does anyone have any ideas or experience with this device?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
