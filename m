Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D255167A2E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 01:48:01 +1000 (EST)
Message-ID: <44D21AFA.2010900@ru.mvista.com>
Date: Thu, 03 Aug 2006 19:49:14 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>	<1154549483.19994.46.camel@cashmere.sps.mot.com>	<BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>	<1154550970.19994.57.camel@cashmere.sps.mot.com>
	<F4FA8DDC-0490-4792-8B9B-89D3F0AECF26@kernel.crashing.org>
In-Reply-To: <F4FA8DDC-0490-4792-8B9B-89D3F0AECF26@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:
> Here is the code modification to fsl_soc.c, I'm sure we can get this  
> fixed push into 2.6.18 if desired.

> if(mac_addr = get_property(np, "address", NULL))
>    memcpy(gfar_data.mac_addr, mac_addr, 6);
> 
> if(mac_addr = get_property(np, "local-mac-address", NULL);
>    memcpy(gfar_data.mac_addr, mac_addr, 6);

    BTW, doesn't it also have sense to convert gianfar.c to using of_device 
instead of platform_device?

WBR, Sergei
