Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id E7422DE17B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:08:49 +1000 (EST)
Received: by gxk14 with SMTP id 14so10130241gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 07:08:48 -0700 (PDT)
Message-ID: <7d1d9c250809290708i763b1739pe4ef1bd86ce6a329@mail.gmail.com>
Date: Mon, 29 Sep 2008 10:08:48 -0400
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Sender: paul.gortmaker@gmail.com
To: "Becky Bruce" <becky.bruce@freescale.com>
Subject: Re: [PATCH 1/2] Drop redundant machine type print in show_cpuinfo
In-Reply-To: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 5:53 PM, Becky Bruce <becky.bruce@freescale.com> wrote:
> For many of the embedded boards, "model" and "Machine" are printing
> the same thing; remove the redundant code and allow the generic
> show_cpuinfo to print the model information.

Sounds good to me.  Thanks for changing the sbc boards as well.

>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

> ---
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    1 -
>  arch/powerpc/platforms/85xx/sbc8560.c             |    1 -
>  arch/powerpc/platforms/86xx/gef_sbc610.c          |    8 --------
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    8 --------
>  arch/powerpc/platforms/86xx/sbc8641d.c            |    8 --------
>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
>  6 files changed, 0 insertions(+), 27 deletions(-)
>
