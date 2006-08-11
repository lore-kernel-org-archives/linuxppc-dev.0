Return-Path: <TKLEIN@de.ibm.com>
In-Reply-To: <20060810053024.C691F67A5E@ozlabs.org>
To: Michael Neuling <mikey@neuling.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] ehea: Kernel build (Kconfig / Makefile)
Message-ID: <OFE2F0858C.27A0FCEC-ONC12571C7.002B6A8F-C12571C7.002BE93A@de.ibm.com>
From: Thomas Q Klein <TKLEIN@de.ibm.com>
Date: Fri, 11 Aug 2006 10:03:22 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 002BE936C12571C7_="
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, mikey@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 002BE936C12571C7_=
Content-Type: text/plain; charset="US-ASCII"

mikey@ozlabs.org wrote on 10.08.2006 07:30:24:

> > --- linux-2.6.18-rc4/drivers/net/Makefile   2006-08-06 
11:20:11.000000000 -
> 0700
> > +++ patched_kernel/drivers/net/Makefile   2006-08-08 
03:00:30.061451584 -
> 0700
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
> >   obj-$(CONFIG_IBM_EMAC) += ibm_emac/
> >   obj-$(CONFIG_IXGB) += ixgb/
> >   obj-$(CONFIG_CHELSIO_T1) += chelsio/
> > +obj-$(CONFIG_EHEA) += ehea/
> >   obj-$(CONFIG_BONDING) += bonding/
> >   obj-$(CONFIG_GIANFAR) += gianfar_driver.o
> 
> Looks like the whitespace has been munged here... 
> 
> Mikey

I see it looks damaged but infact it isn't. All obj-$(CONFIG_*) lines in
the Makefile start at column 0 and so does the one I added. I don't know
why it appears in the diff like that.

Thomas

--=_alternative 002BE936C12571C7_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>mikey@ozlabs.org wrote on 10.08.2006 07:30:24:<br>
<br>
&gt; &gt; --- linux-2.6.18-rc4/drivers/net/Makefile &nbsp; 2006-08-06 11:20:11.000000000
-<br>
&gt; 0700<br>
&gt; &gt; +++ patched_kernel/drivers/net/Makefile &nbsp; 2006-08-08 03:00:30.061451584
-<br>
&gt; 0700<br>
&gt; &gt; @@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/<br>
&gt; &gt; &nbsp; obj-$(CONFIG_IBM_EMAC) += ibm_emac/<br>
&gt; &gt; &nbsp; obj-$(CONFIG_IXGB) += ixgb/<br>
&gt; &gt; &nbsp; obj-$(CONFIG_CHELSIO_T1) += chelsio/<br>
&gt; &gt; +obj-$(CONFIG_EHEA) += ehea/<br>
&gt; &gt; &nbsp; obj-$(CONFIG_BONDING) += bonding/<br>
&gt; &gt; &nbsp; obj-$(CONFIG_GIANFAR) += gianfar_driver.o<br>
&gt; <br>
&gt; Looks like the whitespace has been munged here... <br>
&gt; <br>
&gt; Mikey<br>
</font></tt>
<br><tt><font size=2>I see it looks damaged but infact it isn't. All obj-$(CONFIG_*)
lines in</font></tt>
<br><tt><font size=2>the Makefile start at column 0 and so does the one
I added. I don't know</font></tt>
<br><tt><font size=2>why it appears in the diff like that.</font></tt>
<br>
<br><tt><font size=2>Thomas</font></tt>
<br>
--=_alternative 002BE936C12571C7_=--
