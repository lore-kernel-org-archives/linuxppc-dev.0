Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Remove defconfigs
In-reply-to: <1395710972.12479.418.camel@snotra.buserror.net>
References: <12121.1395710142@ale.ozlabs.ibm.com>
 <1395710972.12479.418.camel@snotra.buserror.net>
Date: Tue, 25 Mar 2014 12:59:47 +1100
Message-ID: <14341.1395712787@ale.ozlabs.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Lijun Pan <Lijun.Pan@freescale.com>,
 Mingkai Hu <Mingkai.Hu@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

> On Tue, 2014-03-25 at 12:15 +1100, Michael Neuling wrote:
> > These are always breaking and I feel like I'm the only one fixing them
> > and 
> 
> Always?  Please elaborate.

Maybe once every 2-3 months I have to send a fix up for them.

> > I don't even have one of these boards so let's just remove them.
> 
> What does you having one of these boards have to do with anything?

Well it feels like I'm the only one fixing them (which I guess isn't
true), and I don't even really care about them.

> > They are also broken right now in linux-next when compiling modules.
> 
> A fix for that breakage is in i2c.git i2c/for-current (commit
> 5f12c5eca6e6b7aeb4b2028d579f614b4fe7a81f).  I sent the patch to fix it
> (I guess you're not "the only one fixing them") the day I found out
> about the breakage.  The breakage was introduced by commits from the i2c
> tree, including one late in the rc cycle that enables a driver that
> hadn't been enabled in a while (let's not do that again please).

Great.

> 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > 
> > diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> > deleted file mode 100644
> > index 19f0fbe..0000000
> > --- a/arch/powerpc/configs/mpc85xx_defconfig
> > +++ /dev/null
> > @@ -1,272 +0,0 @@
> 
> NACK

Fair enough.  It was more of a probe to see who really cared about
them.  Clearly someone does.

> I'm curious why you only removed this one defconfig when
> mpc85xx_smp_defconfig had the same problem...

Should have been both.. I screwed that up.

Mikey
