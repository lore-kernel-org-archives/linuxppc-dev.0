Return-Path: <ihornberger@sysgo.de>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 51BC4687FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 21:09:23 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 0C0FDFB869
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 11:09:21 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id EDF12FB869
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 11:09:20 +0100 (CET)
Received: from iho.sysgo.com (iho.sysgo.com [172.22.47.10])
	by donald.sysgo.com (Postfix) with ESMTP id B5DA219DD44
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 11:09:18 +0100 (CET)
From: Ingo Hornberger <ihornberger@sysgo.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <438B379B.6090904@ru.mvista.com>
References: <438B379B.6090904@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 11:07:42 +0100
Message-Id: <1133258862.2664.13.camel@iho.sysgo.com>
Mime-Version: 1.0
Subject: Re: [PATCH] ppc32: Adds MPC885ADS, MPC866ADS and
	MPC8272ADS-specific platform stuff for fs_enet
Reply-To: ihornberger@sysgo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

OK, I don't really see the advantage of removing the identification
stuff, but perhaps I'm missing something. Was there any discussion in
the past that I've skipped while reading through the archive?

Because I found the identifcation code really nice. The only problem was
that my 8xx didn't support the SVR register.

regards,
	Ingo

On Mon, 2005-11-28 at 20:00 +0300, Vitaly Bordug wrote:
> Added proper ppc_sys identification and fs_platform_info's for MPC 885ADS, 866ADS and 
> 8272ADS. Assuming setbitsXX/clrbitsXX patch is applied.
> 
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 
> ---
> Sincerely,
> Vitaly
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
