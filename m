Subject: Re: i2c linux drivers
From: Craig Hollabaugh <craig@hollabaugh.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3F094650.9070204@peak.uklinux.net>
References: <3F093B09.8040605@peak.uklinux.net>
	<3F094650.9070204@peak.uklinux.net>
Content-Type: text/plain
Date: 07 Jul 2003 09:49:26 -0600
Message-Id: <1057592966.979.2.camel@gibson>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2003-07-07 at 04:07, Seb James wrote:
>
> Seb James wrote:
>
> > Hello all,
> >
> > I'm trying to write an i2c driver to interface a ds1307 realtime clock
> > to linux. I'm having no luck getting linux to do anything at all on the
> > i2c bus.


Seb,

If you give up, you can just use the PPC I2C routines I wrote for my
book.

http://www.embeddedlinuxinterfacing.com/chapters/10/SAA1064_rpxcllf.c

I think you can just change the I2C signaling macros for your hardware
and get things running.

I used this code just yesterday for an x86 SBC talking to a DalSemi
digipot.

Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
