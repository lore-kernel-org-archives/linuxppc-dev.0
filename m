Return-Path: <dtor@insightbb.com>
Received: from asav04.insightbb.com (gateway.insightbb.com [74.128.0.19])
	by ozlabs.org (Postfix) with ESMTP id 4C9F1DDE9C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 10:45:52 +1000 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
Date: Mon, 23 Jul 2007 20:45:45 -0400
References: <20070720164043.523003359@mail.of.borg>
	<200707220022.41797.dtor@insightbb.com>
	<Pine.LNX.4.64.0707221451140.18493@anakin>
In-Reply-To: <Pine.LNX.4.64.0707221451140.18493@anakin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707232045.47104.dtor@insightbb.com>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 22 July 2007 08:51, Geert Uytterhoeven wrote:
> On Sun, 22 Jul 2007, Dmitry Torokhov wrote:
> > On Saturday 21 July 2007 04:27, Geert Uytterhoeven wrote:
> > > On Fri, 20 Jul 2007, Dmitry Torokhov wrote:
> > > > I am OK with adding a new header file. I was just saying that placing
> > > > that declaration in linux/hid.h makes about the same sense as putting
> > > > it into linux/scsi.h
> > > 
> > > At first I just wanted to move it. Then I thought about the angry
> > > comments I would get about not moving it to a header file ;-)
> > > 
> > > <linux/hid.h> looked like the best candidate. <linux/kbd_kern.h> is
> > > another option.
> > > 
> > 
> > linux/kbd_kern.h sounds much better.
> 
> And so it will be.

Applied to 'for-linus' branch of input tree, thank you.

-- 
Dmitry
