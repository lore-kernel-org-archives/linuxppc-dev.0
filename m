Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 6684ADE004
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 00:41:21 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so742370pyg.27
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 07:41:19 -0700 (PDT)
Date: Fri, 4 Jul 2008 08:41:17 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080704144117.GA15814@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
	<20080703162809.GH2284@secretlab.ca>
	<B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 07:03:25AM -0400, Timur Tabi wrote:
>> 	i2s@2200 {		// PSC2
>> 		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>> 		cell-index = <1>;
>
> cell-index should be zero-based, not one-based.
>

Umm... this is for PSC #2... cell index is set to '1'.  It is zero
based.

g.
