Return-Path: <benh@kernel.crashing.org>
Subject: Re: Device trees and audio codecs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 08:06:39 +1000
Message-Id: <1193004399.6745.39.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-21 at 17:33 -0400, Jon Smirl wrote:
> > This is one of the i2s channels on the macio.  Dunno why they put
> > all those platform-XXX entries in here, (most of) these don't
> > logically belong here.
> 
> Actually those platform-XXX entries may be the solution I am looking
> for. I can use the generic i2s driver to load a fabric driver as an
> ALSA module.

Yuck.

Ben.
