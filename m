Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710211512v238fbc89m35783d5eb5b82bf6@mail.gmail.com>
Date: Sun, 21 Oct 2007 18:12:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Device trees and audio codecs
In-Reply-To: <1193004399.6745.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
	<1193004399.6745.39.camel@pasglop>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-10-21 at 17:33 -0400, Jon Smirl wrote:
> > > This is one of the i2s channels on the macio.  Dunno why they put
> > > all those platform-XXX entries in here, (most of) these don't
> > > logically belong here.
> >
> > Actually those platform-XXX entries may be the solution I am looking
> > for. I can use the generic i2s driver to load a fabric driver as an
> > ALSA module.
>
> Yuck.

And your alternative is?

I can use the DTC to load the I2S and codec drivers.

How do I get the platform specific fabric driver loaded? There is no
way to load a driver matching on the platform name.

-- 
Jon Smirl
jonsmirl@gmail.com
