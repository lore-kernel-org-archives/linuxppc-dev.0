Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2652FDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 19:19:51 +1000 (EST)
Message-ID: <49F6CA36.3040403@gefanuc.com>
Date: Tue, 28 Apr 2009 10:19:50 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/86xx: Add new LAW & MCM device tree nodes
	for all	86xx systems
References: <1240855188-24879-1-git-send-email-galak@kernel.crashing.org>
	<1240855188-24879-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1240855188-24879-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/gef_ppc9a.dts        |   13 +++++++++++++
>  arch/powerpc/boot/dts/gef_sbc310.dts       |   13 +++++++++++++
>  arch/powerpc/boot/dts/gef_sbc610.dts       |   13 +++++++++++++
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   13 +++++++++++++
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |   13 +++++++++++++
>  arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts |   13 +++++++++++++
>  arch/powerpc/boot/dts/sbc8641d.dts         |   13 +++++++++++++
>  7 files changed, 91 insertions(+), 0 deletions(-)
>   
Am I right in thinking that this patch doesn't (as yet) enable any added 
functionality, or have I missed something?

I assume this is destined for next (as it relies on Becky's 
"powerpc/86xx: Add 36-bit device tree for mpc8641hpcn"), assuming this, 
fwiw, seems good to me.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
