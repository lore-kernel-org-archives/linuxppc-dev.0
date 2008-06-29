Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.249])
	by ozlabs.org (Postfix) with ESMTP id CEDC9DDF14
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 18:01:30 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so4721090agc.0
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 01:01:29 -0700 (PDT)
Message-ID: <fa686aa40806290101w59e80f48ue7e7ae103993c3fe@mail.gmail.com>
Date: Sun, 29 Jun 2008 02:01:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 3/8][Version 2] MPC5121 Add generic board support
In-Reply-To: <1214342672-23536-4-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
	<1214342672-23536-2-git-send-email-jrigby@freescale.com>
	<1214342672-23536-3-git-send-email-jrigby@freescale.com>
	<1214342672-23536-4-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2008 at 3:24 PM, John Rigby <jrigby@freescale.com> wrote:
> Move shared code from mpc5121_ads.c to mpc512x_shared.c.
> Add new generic board setup mpc5121_generic.c
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> +void __init mpc512x_init_IRQ(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,ipic");

Along with all my other device-tree conventions comments; you should
really be testing for fsl,mpc5121-ipic here.  fsl,ipic is not a good
value for compatible.

g.
