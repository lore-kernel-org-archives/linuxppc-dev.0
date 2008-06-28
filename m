Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id 68898DDF1B
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 05:16:18 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so4148371agc.0
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 12:16:17 -0700 (PDT)
Message-ID: <fa686aa40806281216v71f33a70n67eca1c1e69417d8@mail.gmail.com>
Date: Sat, 28 Jun 2008 13:16:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [PATCH] Fix wrong 'no interrupt' handling in of_i2c
In-Reply-To: <20080628183141.15298.2758.stgit@octopus.labnet.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080628183141.15298.2758.stgit@octopus.labnet.pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 28, 2008 at 12:31 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> If an I2C device node does not specify an interrupt, the .irq member of the
> board_info struct was set to -1. This caused crashes on following
> irq_dispose_mappings. Leave it NO_IRQ as returned from irq_of_parse_and_map.
> (Suggesting -1 as 'i2c-no-irq' used to be a bug in linux/i2c.h.)
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
