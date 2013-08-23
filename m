Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA4C52C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 07:48:17 +1000 (EST)
Date: Fri, 23 Aug 2013 23:48:14 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 05/31] [media] fsl-viu: cleanup clock API use
Message-ID: <20130823234814.789f9f44@crub>
In-Reply-To: <1375821851-31609-6-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-6-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:45 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> use devm_clk_get() for automatic put after device close, check for and
> propagate errors when enabling clocks, need to prepare clocks before
> they can get enabled, adjust code paths to correctly balance get/put and
> prepare/unprepare and enable/disable calls
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/media/platform/fsl-viu.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Applied to mpc5xxx tree, thanks!

Anatolij
