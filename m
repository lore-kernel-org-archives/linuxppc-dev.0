Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188]) by ozlabs.org (Postfix) with ESMTP id 8C4EFB7B68
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 15:12:04 +1000 (EST)
Received: by pzk26 with SMTP id 26so532559pzk.4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 22:12:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090921220815.D63D854004B@mail96-sin.bigfish.com>
References: <20090921220815.D63D854004B@mail96-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Sep 2009 22:11:43 -0700
Message-ID: <fa686aa40909212211g4702926dj3bf80482d31f6b7a@mail.gmail.com>
Subject: Re: [PATCH] [V2] USB: Add support for Xilinx USB host controller
To: Julie Zhu <julie.zhu@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 3:08 PM, Julie Zhu <julie.zhu@xilinx.com> wrote:
> Add bus glue driver for Xilinx USB host controller. The controller can be
> configured as HS only or HS/FS hybrid. The driver uses the device tree file
> to configure the driver according to the setting in the hardware system.
>
> This driver has been tested with usbtest using the NET2280 PCI card.
>
> Signed-off-by: Julie Zhu <julie.zhu@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
