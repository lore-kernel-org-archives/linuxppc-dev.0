Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 5A0F1DE00A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 03:34:59 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so2324913nfd
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 10:34:57 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mpc8xx: Only build mpc8xx on arch/ppc
Date: Mon, 27 Aug 2007 18:41:12 +0200
References: <Pine.LNX.4.64.0708222304500.7960@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0708222304500.7960@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708271841.12780.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 August 2007, Kumar Gala wrote:
> Currently the mpc8xx ide driver will only work on arch/ppc so only
> allow it to be built there.  Also, killed a minor include that isn't
> actually used by the driver.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

applied
