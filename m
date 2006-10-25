Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
References: <453FB582.20802@bplan-gmbh.de>
	<528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 09:06:16 +1000
Message-Id: <1161817576.22582.142.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 17:01 -0600, Grant Likely wrote:
> Thanks Nicolas, I'll dig through the PIC code tonight.  I'm really not
> sure about the implications of this being a CHRP board vs. the
> Lite5200 using u-boot.  ie. Should the Lite5200 also be a CHRP
> platform?  Does u-boot provide enough capability (this is where my
> ignorance about CHRP shines through)

Bah, if you have no RTAS, don't bother being CHRP.

> > * serial stuff / IBP Freq. As this frequency is MPC52xx specific. I
> > think it would make sense to add a new func mpc52xx_getipbfreq(void).
> > The way it would be implemented may depend of the architecture. Our
> > firmware contains an 'ipb-freq' property in '/builtin/'.

BTW. I forgot to comment on the above in my previous mail... As I said,
there should be no such thing. Instead, the IPB freq should be in the
device-tree.
