Return-Path: <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 15:25:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
Message-ID: <20080625152542.40003d30@hyperion.delvare>
In-Reply-To: <9e4733910806110914v2fb9e4a3o3736663bd54a03cd@mail.gmail.com>
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080611160048.GB4257@pengutronix.de>
	<9e4733910806110914v2fb9e4a3o3736663bd54a03cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Wolfram Sang <w.sang@pengutronix.de>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Wed, 11 Jun 2008 12:14:08 -0400, Jon Smirl wrote:
> On 6/11/08, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > On Tue, Jun 10, 2008 at 10:40:45PM -0400, Jon Smirl wrote:
> >  > Convert i2c-mpc from a platform driver into an of_platform driver.
> >  > This patch is much smaller since Jochen already added
> >  > of_find_i2c_driver(). Versions of this have been posted before.
> >  >
> >  > Signed-ff-by: Jon Smirl <jonsmirl@gmail.com>
> >
> > Typo: Signed-off... (I'm curious, do such typos enforce resending the
> >  patch?)

In theory it should. The line means that you've read the "Developer's
Certificate of Origin" and you agree with it, so it's somewhat binding.
I guess a lawyer would argue that the line isn't worth anything if
"Signed-off-by" isn't spelled properly.

Thanks Wolfram for the review, BTW.

> I just cut and pasted this version to get the comments. Next pass I
> will send it using stgit which will add the right signed-off line and
> fix the wrapping.

That's doing things the wrong way around. If you want people to comment
on your patch, the least you can do is make sure they can apply it.

If I can't apply your patch, that means I can't verify if it applies
properly, I can't run checkpatch.pl on it, I can't get quilt to color
it, and I can't compare it to a previous version of the same patch.

Also, it would be a good idea to keep Jochen Friedrich in the loop
(Cc'd), as he proposed a similar patch based on a previous version of
yours back in April. I suppose he has some interest in it.

While mentioning Jochen's version of the patch: it was deleting 123
lines from arch/powerpc/sysdev/fsl_soc.c. Yours doesn't. Should it?
http://lists.lm-sensors.org/pipermail/i2c/2008-April/003314.html

-- 
Jean Delvare
