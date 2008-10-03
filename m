Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B709DE005
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 07:57:52 +1000 (EST)
Message-Id: <497F4C67-0838-4725-B2EC-6510515AC0A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081001124620.23955.42588.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: FPGA support for GE Fanuc SBC610
Date: Fri, 3 Oct 2008 16:57:43 -0500
References: <20081001124620.23955.42588.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 1, 2008, at 7:46 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This patch adds support for the registers held in the devices main  
> FPGA,
> exposing extra information about the revision of the board through  
> cpuinfo.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---

this doesn't apply for me.

- k
