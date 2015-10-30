Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A2BB1A0CAA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 07:03:25 +1100 (AEDT)
Message-ID: <1446235386.22185.39.camel@freescale.com>
Subject: Re: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
From: Scott Wood <scottwood@freescale.com>
To: Raghav Dogra <raghav@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <prabhakar@freescale.com>
Date: Fri, 30 Oct 2015 15:03:06 -0500
In-Reply-To: <1446186299-2921-1-git-send-email-raghav@freescale.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-30 at 11:54 +0530, Raghav Dogra wrote:
> Modify platform driver suspend/resume to syscore
> suspend/resume. This is because p1022ds needs to use
> localbus when entering the PCIE resume.
> 
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
>  arch/powerpc/sysdev/Makefile  |  2 +-
>  arch/powerpc/sysdev/fsl_lbc.c | 51 +++++++++++++++++++++++++++++++++-------
> ---
>  2 files changed, 40 insertions(+), 13 deletions(-)

Same comments as on the IFC patch.

-Scott
