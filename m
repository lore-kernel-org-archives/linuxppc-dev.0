Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 47431DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 14:29:43 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so679654anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Apr 2008 21:29:34 -0700 (PDT)
Message-ID: <fa686aa40804092129v7939fceby3a82ab81b8f9794@mail.gmail.com>
Date: Wed, 9 Apr 2008 22:29:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
In-Reply-To: <20080410142430.256fd23e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<20080410103131.f0dcf730.sfr@canb.auug.org.au>
	<6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
	<20080410142430.256fd23e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 9, 2008 at 10:24 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 9 Apr 2008 22:11:38 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:
>  >
>  > Yeah the are mpc85xx_defconfig and mpc83xx_defconfig.
>
>  So should we add mpc83xx_defconfig to the kisskb builds and remove
>  mpc885_ads_defconfig (we already do a mpc85xx_defconfig build)?

Can mpc52xx_defconfig be added too?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
