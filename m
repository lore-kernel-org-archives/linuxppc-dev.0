Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 732CDB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:40:51 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id C5824DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 01:40:49 +1000 (EST)
Received: by yxe37 with SMTP id 37so6929366yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 08:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849D7EE1A@ex01.ads.ubidyne.de>
References: <Acn10GL8UFkH8grcTWecohRthafWswCvtYhQ>
	<29DC34A6B43468409F5A371CFE34E849D7EE1A@ex01.ads.ubidyne.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 29 Jun 2009 09:40:28 -0600
Message-ID: <fa686aa40906290840p6e1b1f4eo5b055aceb60acc74@mail.gmail.com>
Subject: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 2:23 AM, Frank
Prepelica<Frank.Prepelica@ubidyne.com> wrote:
> Hi Grant
>
> Thanks for your response!
>
> I have searched for "current-speed" in drivers/net/fec_mpc52xx.c but I cannot find anything. However we are using the gianfar.c Ethernet driver.
> Do you know whether this driver supports fixed MII links without PHY?

What kernel version are you using?

> I've got another question regarding MII connection between and MPC and a Virtex FPGA. Whats about the PHY address which has to be set in the DTB file? Do I have to modify the DTB at all?

Yes, you need to modify the DTB.  You have a back to back MII
connection, not a phy, so you do *not* want to have a PHY node in the
device tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
