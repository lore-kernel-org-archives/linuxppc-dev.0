Date: Thu, 19 Sep 2002 10:47:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: lynxfb.c
Message-ID: <20020919004744.GB1692@zax>
References: <20020918162705.2286.qmail@webmail26.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020918162705.2286.qmail@webmail26.rediffmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 18, 2002 at 04:27:05PM -0000, Linux  PPC wrote:
>
> Hello,
>
> Has anybody seen it working? We are using sensoray
> video module, which uses Lynx3DM chip.

The framebuffer driver as a whole is incomplete, and won't work as a
frame buffer driver.  If someone were to correct that, that would be a
Good Thing (tm).

I wrote the driver for use on the Embedded Planet Icebox (Sensoray 322
module).  I was primarily using the XFree86 siliconmotion driver, but
this makes some PCish assumptions.  I wrote the framebuffer driver to
do the basic initialization of the card - with the fb driver loaded
it's relatively easy to get X working.  I intended to complete it -
i.e. make it a fully working fb driver, but I never had the time.

Note that the fb driver does do one particularly important thing - it
initializes the memory subsystem using some undocumented prodding of
the card.  On PCs this is performed by the card BIOS, and the video
memory won't work correctly without it.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
