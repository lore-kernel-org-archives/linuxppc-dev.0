Return-Path: <wolfgang@leila.ping.de>
Received: from lilly.ping.de (lilly.ping.de [83.97.42.2])
	by ozlabs.org (Postfix) with SMTP id 02CFADDFC3
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 02:48:21 +1100 (EST)
Date: Fri, 23 Jan 2009 14:40:02 +0100
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MicroSD (SPI mode) support in Linux-2.6.26-1
Message-ID: <20090123134001.GR2004@leila.ping.de>
References: <dd2f3b320901221959w956ccc6r3b700633acbefd3a@mail.gmail.com>
	<4979BB83.5060506@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4979BB83.5060506@matrix-vision.de>
From: wolfgang@leila.ping.de (Wolfgang Wegner)
Cc: linuxppc-dev@ozlabs.org, Sai Amruta <amrutasai.p@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andre,

On Fri, Jan 23, 2009 at 01:43:47PM +0100, Andre Schwarz wrote:
> 
> Sai Amruta wrote:
> >Hi All,
> >
> >I am using linux-2.6.26 on MPC8567 and microSD is connected through 
> >SPI interface.
> >Is the existing mmc driver supports microSD?
> yes - it's working perfectly fine on my MPC8343.
> Even with SDHC cards ;-)

that's great to hear - is there anything like a HOWTO on how to set
this up on top of the SPI driver (probably involving some custom GPIO
stuff for card and WP detection) out there?
I tried to but did not get it to work on MCF53xx (uClinux 2.6.23-uc0)
and probably did not find the right search strings either.

Regards,
Wolfgang
