Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 1CB10DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:14:51 +1000 (EST)
Received: by qyk29 with SMTP id 29so6482739qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 13:14:50 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
Date: Fri, 1 May 2009 15:14:50 -0500
Message-ID: <ed82fe3e0905011314h66c33a6nf87e32917923409a@mail.gmail.com>
Subject: Re: [PATCH 4/6 v2] powerpc/qe: update QE Serial Number
From: Timur Tabi <timur@freescale.com>
To: Haiying Wang <Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 1, 2009 at 2:40 PM, Haiying Wang <Haiying.Wang@freescale.com> wrote:
> The latest QE chip may have more Serial Number(SNUM)s of thread to use. We will
> get the number of SNUMs from device tree by reading the new property
> "fsl,qe-num-snums", and set 28 as the default number of SNUMs so that it is
> compatible with the old QE chips' device trees which don't have this new
> property. The macro QE_NUM_OF_SNUM is defined as the maximum number in QE snum
> table which is 256.
> Also we update the snum_init[] array with 18 more new SNUMs which are
> confirmed to be useful on new chip.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
