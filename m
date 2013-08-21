Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 376832C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 06:45:30 +1000 (EST)
Date: Wed, 21 Aug 2013 22:45:25 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 03/31] USB: fsl-mph-dr-of: cleanup clock API use
Message-ID: <20130821224525.744756e3@crub>
In-Reply-To: <1375821851-31609-4-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-4-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:43 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> use devm_get_clk() for automatic put upon device close, check for and
> propagate errors when enabling clocks, must prepare clocks before they
> can get enabled, unprepare after disable
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/usb/host/fsl-mph-dr-of.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

applied, thanks!

Anatolij
