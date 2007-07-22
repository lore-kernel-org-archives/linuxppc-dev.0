Return-Path: <dtor@insightbb.com>
Received: from asav06.insightbb.com (gateway.insightbb.com [74.128.0.19])
	by ozlabs.org (Postfix) with ESMTP id AE4A3DDEFF
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 14:22:45 +1000 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
Date: Sun, 22 Jul 2007 00:22:40 -0400
References: <20070720164043.523003359@mail.of.borg>
	<d120d5000707201151q433f1f3eteb479109291a54bd@mail.gmail.com>
	<Pine.LNX.4.64.0707211026070.18493@anakin>
In-Reply-To: <Pine.LNX.4.64.0707211026070.18493@anakin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707220022.41797.dtor@insightbb.com>
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

Hi Geert,

On Saturday 21 July 2007 04:27, Geert Uytterhoeven wrote:
> On Fri, 20 Jul 2007, Dmitry Torokhov wrote:
> > 
> > I am OK with adding a new header file. I was just saying that placing
> > that declaration in linux/hid.h makes about the same sense as putting
> > it into linux/scsi.h
> 
> At first I just wanted to move it. Then I thought about the angry
> comments I would get about not moving it to a header file ;-)
> 
> <linux/hid.h> looked like the best candidate. <linux/kbd_kern.h> is
> another option.
> 

linux/kbd_kern.h sounds much better.

-- 
Dmitry
