Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711191055w316eda6se0b67c34b814af3f@mail.gmail.com>
Date: Mon, 19 Nov 2007 11:55:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <20071119170521.GA4368@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<20071119001209.GD20794@localhost.localdomain>
	<4741BA7D.10608@genesi-usa.com>
	<20071119170521.GA4368@loki.buserror.net>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Nov 19, 2007 at 04:31:57PM +0000, Matt Sealey wrote:
> > I never said drivers should depend on it but why do you want to name
> > an i2s bus as "i2s" or the i2c bus as "i2c"?
>
> Because that's what they are?
>
> > There are far, far more descriptive names that can be used. i2s is
> > basically audio, so why not "audio" or "sound" or "headphone"?
>
> For i2s, that may be reasonable, but i2c can have several devices under it.
>
> > Why is gpt a "gpt" and not a "timer", it defeats the whole object
> > of having a name for it. Since drivers never switch on it, why not
> > give them real names?
>
> That one *should* be timer.  Ask whoever did the device tree for it. :-P

That one's my fault.

sorry.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
