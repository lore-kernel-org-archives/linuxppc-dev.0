Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 529692C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 13:52:48 +1100 (EST)
Date: Wed, 4 Dec 2013 16:55:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 11/17] USB: fsl-mph-dr-of: adjust for OF based clock
 lookup
Message-ID: <20131205005533.GB21377@kroah.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-12-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385851897-23475-12-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 linux-usb@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 30, 2013 at 11:51:31PM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the component
> index -- remove the "usb%d_clk" template, always use "ipg" instead
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
