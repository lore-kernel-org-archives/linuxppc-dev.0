Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id 822D9DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:48:01 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
Date: Wed, 24 Sep 2008 13:28:34 -0700
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
	<1220343329.7762.23.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1220343329.7762.23.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241328.35008.david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 September 2008, Joakim Tjernlund wrote:
> 
> > Noted:  AFAIK, RNDIS gadget in Linux doesn't interoperate with windows
> > well enough to be production level.  Use at your own risk.
> 
> I see. If one wants to connect with CDC to Windows, what drivers are
> there for Windows that works well with Linux?

I believe MCCI has some.  It also has drivers for a CDC subset,
pretty much the same one Linux has used forever except wrapped
with a few extra descriptors to make it practical to identify
that "SAFE" (!) subset without needing vendor and product IDs.

- Dave
