Return-Path: <tlinder@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine01.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 681ABB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 21:52:47 +1000 (EST)
From: "Tanya Brokhman" <tlinder@codeaurora.org>
To: <balbi@ti.com>
References: <1307877290-26672-1-git-send-email-tlinder@codeaurora.org>
	<20110613092438.GK3633@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110613092438.GK3633@legolas.emea.dhcp.ti.com>
Subject: RE: [PATCH] usb:gadget: use min_t() macro instead of min()
Date: Mon, 13 Jun 2011 14:52:34 +0300
Message-ID: <03b901cc29c0$6538e970$2faabc50$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: ablay@codeaurora.org, greg@kroah.com, linux-usb@vger.kernel.org,
	'open list' <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	"'open list:OMAP USB SUPPORT'" <linux-omap@vger.kernel.org>,
	"'open list:FREESCALE USB PER...'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> On Sun, Jun 12, 2011 at 02:14:46PM +0300, Tatyana Brokhman wrote:
> > Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>
> 
> I need a sensible commit log for this. Why do we need to change all
> min() to min_t() ?
> 

Actually, Alan asked me to make this change in one place in dummy_hcd. I
wasn't aware of the min_t macro before that. So when I searched the code for
other places I found quite a few and just thought that it would be "nicer"
to use min_t() instead of min() with casting. 
So we don't "need" to make this change. Everything works as is. This patch
only makes the code look nicer, nothing more.
I can elaborate the above in the commit log if you want.


Thanks,
Tanya Brokhman
---
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
