Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id C5F2EB7B6B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 00:47:15 +1000 (EST)
Received: by yxe8 with SMTP id 8so3801990yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 07:47:14 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090921144131.1C1A31078051@mail56-sin.bigfish.com>
References: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
	<fa686aa40909210714j428aa524qacc7a83f40db411b@mail.gmail.com>
	<20090921144131.1C1A31078051@mail56-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Sep 2009 07:46:54 -0700
Message-ID: <fa686aa40909210746g1e98e436kcbc4a8ffa1e416fc@mail.gmail.com>
Subject: Re: [PATCH] USB: Add support for Xilinx USB host controller
To: Julie Zhu <julie.zhu@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 7:41 AM, Julie Zhu <julie.zhu@xilinx.com> wrote:
> I have changed the compatible to "xlnx,xps-usb-host-1.00.a", thanks for catching this.
>
> Where should I put the binding for Xilinx USB host controller? usb-ehci.txt or xilinx.txt?

Probably xilinx.txt.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
