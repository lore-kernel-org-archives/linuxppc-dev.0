Subject: Re: [PATCH] fix build of ibmstb4 and ibmstbx25
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030924171739.GA30820@ip68-0-152-218.tc.ph.cox.net>
References: <1064372689.822.13.camel@shiva.eth.saftware.de>
	 <20030924171739.GA30820@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1064437206.1807.42.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: 24 Sep 2003 23:00:07 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-09-24 at 19:17, Tom Rini wrote:
> On Wed, Sep 24, 2003 at 05:04:49AM +0200, Andreas Oberritter wrote:
>
> > Hi Tom,
> >
> > config.in.diff adds two missing '$' for config variables in
> > arch/ppc/config.in and the two other patches update the ocp definitions
> > for the stb4xxx and stbx25xx CPUs, so they can be built again. I used
> > linuxppc_2_4_devel, but they are needed for linuxppc-2.4, too.
>
> Applied.  Does this mean you have the HW and can test things?

Thanks!

Yes, I have a set-top-box using the stb4500. I don't have an stbx25xx
yet, but there are or will be some interesting boxes on the market using
it.

I found two more bugs in linuxppc-2.4:

ppc405_wdt.c is missing, but it is available as a config option.

embed_config.c contains an #endif below #include <asm/io.h> without a
matching #if.

Unfortunately I can't send patches at the moment because my harddisk
died partially this morning...

Btw, thanks for applying the dbox2 patches! Will the watchdog code be
merged in before 2.4.23, too?

Regards,
Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
