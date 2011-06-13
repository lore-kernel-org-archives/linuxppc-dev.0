Return-Path: <tlinder@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine01.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B0213B6FB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 04:08:03 +1000 (EST)
From: "Tanya Brokhman" <tlinder@codeaurora.org>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
References: <03b901cc29c0$6538e970$2faabc50$@org>
	<Pine.LNX.4.44L0.1106131036430.1983-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1106131036430.1983-100000@iolanthe.rowland.org>
Subject: RE: [PATCH] usb:gadget: use min_t() macro instead of min()
Date: Mon, 13 Jun 2011 21:07:52 +0300
Message-ID: <03db01cc29f4$d472bcb0$7d583610$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: "'open list:FREESCALE USB PER...'" <linuxppc-dev@lists.ozlabs.org>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	'open list' <linux-kernel@vger.kernel.org>, balbi@ti.com,
	linux-arm-msm@vger.kernel.org,
	"'open list:OMAP USB SUPPORT'" <linux-omap@vger.kernel.org>,
	ablay@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> The change I suggested involved replacing two typecasts with a single
> min_t.  All (or almost all) the places this patch touches currently
> contain only one typecast, so the motivation for changing them is a lot
> weaker.
> 
You're right. So what's the final call on this one? Do you think it can be
merged or you prefer not change anything? I personally think the code looks
nicer using min_t instead of min with casting but that's just my opinion and
of course there are arguments against this patch.


Thanks,
Tanya Brokhman
---
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
