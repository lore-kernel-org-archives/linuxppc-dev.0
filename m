From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.6.4-rc2] Disable Macintosh device drivers for all but PPC
Date: Tue, 9 Mar 2004 19:30:58 +0100
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <200403072117.47345@WOLK> <1078697211.5704.164.camel@gaston> <Pine.GSO.4.58.0403081945520.16049@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0403081945520.16049@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_i1gTAyX1ASHrfL0"
Message-Id: <200403091930.58459@WOLK>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_i1gTAyX1ASHrfL0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 08 March 2004 19:46, Geert Uytterhoeven wrote:

Hi,

> On Mon, 8 Mar 2004, Benjamin Herrenschmidt wrote:
> > On Mon, 2004-03-08 at 07:50, Marc-Christian Petersen wrote:
> > > I think the attached patch is needed to stop showing us "Macintosh
> > > device drivers" for all architectures via menuconfig || xconfig ||
> > > gconfig.
> >
> > ... and m68k :)
> Indeed. So please add `|| MAC'.

ok :)

ciao, Marc

--Boundary-00=_i1gTAyX1ASHrfL0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mac-menu-for-ALL-arches-eh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mac-menu-for-ALL-arches-eh.patch"

diff -Naurp linux-2.6.4-rc1/drivers/macintosh/Kconfig linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig
--- linux-2.6.4-rc1/drivers/macintosh/Kconfig	2004-03-07 20:52:34.000000000 +0100
+++ linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig	2004-03-07 21:12:47.000000000 +0100
@@ -1,5 +1,6 @@

 menu "Macintosh device drivers"
+	depends on PPC || MAC

 config ADB
 	bool "Apple Desktop Bus (ADB) support"

--Boundary-00=_i1gTAyX1ASHrfL0--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
