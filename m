Return-Path: <richardcochran@gmail.com>
Received: from mail-ee0-x22e.google.com (mail-ee0-x22e.google.com
 [IPv6:2a00:1450:4013:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84CC72C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 03:14:26 +1000 (EST)
Received: by mail-ee0-f46.google.com with SMTP id c13so2629977eek.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:14:21 -0700 (PDT)
Date: Tue, 24 Sep 2013 19:14:10 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Subject: Re: [PATCH] powerpc/83xx: gianfar_ptp: select 1588 clock source
 through dts file
Message-ID: <20130924171410.GB4073@netboy>
References: <1380008397-22980-1-git-send-email-aida.mynzhasova@skitlab.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380008397-22980-1-git-send-email-aida.mynzhasova@skitlab.ru>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 24, 2013 at 11:39:57AM +0400, Aida Mynzhasova wrote:
> Currently IEEE 1588 timer reference clock source is determined through
> hard-coded value in gianfar_ptp driver. This patch allows to select ptp
> clock source by means of device tree file node.
> 
> For instance:
> 
> 	fsl,cksel = <0>;
> 
> for using external (TSEC_TMR_CLK input) high precision timer
> reference clock.
> 
> Other acceptable values:
> 
> 	<1> : eTSEC system clock
> 	<2> : eTSEC1 transmit clock
> 	<3> : RTC clock input

I think it would be useful to have this table in the binding document
as well.

Thanks,
Richard
