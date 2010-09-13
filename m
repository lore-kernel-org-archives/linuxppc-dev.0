Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id B37D81007D9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 14:40:02 +1000 (EST)
Received: by pvg16 with SMTP id 16so3004344pvg.15
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Sep 2010 21:40:00 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 12 Sep 2010 22:39:57 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100913043957.GA2144@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
	<20100910173706.GD11284@angua.secretlab.ca>
	<1284142484.2152.18.camel@swa-e6500>
	<20100910182815.GH11284@angua.secretlab.ca>
	<1284304235.2913.8.camel@swa-e6500>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1284304235.2913.8.camel@swa-e6500>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 12, 2010 at 05:10:35PM +0200, André Schwarz wrote:
> > > BTW: would "drivers/misc" be a proper location ?
> > > Who's supposed to pick that driver up and on what list shall I post it
> > > for review ?
> > 
> > You should cc spi-devel-general, and feel free to cc me.  drivers/misc
> > would probably be an okay place for it to live; but if it only appears
> > on a single machine, then it may make more sense in
> > arch/*/<board-directory>.  What arch or SoC is this running on?
> 
> ok - currently I'm preparing bring up of a MPC8377 based system.
> But we have this chips on multiple boards and also on generic PCIe
> grabber cards running on any desktop PC.
> 
> Since we could use the driver directly after registering the various I2C
> masters I'd prefer to go with drivers/misc. After all it's a simple I2C
> slave device usable by anyone ...

If it is a video capture device, then wouldn't drivers/video
or drivers/media make sense?  Search for "MEDIA INPUT" in the
MAINTAINERS file.

g.
