Return-Path: <rmantovani@libero.it>
Received: from smtp-out2.libero.it (smtp-out2.libero.it [212.52.84.42])
	by ozlabs.org (Postfix) with ESMTP id 0D6D4DDF12
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Jan 2007 01:16:03 +1100 (EST)
Received: from localhost (172.31.0.46) by smtp-out2.libero.it (7.3.120)
	id 458BB42100A331BE for linuxppc-embedded@ozlabs.org;
	Fri, 12 Jan 2007 15:06:59 +0100
Received: from smtp-out2.libero.it ([172.31.0.38])
	by localhost (asav-out5.libero.it [192.168.32.33]) (amavisd-new,
	port 10024)
	with ESMTP id I6DVTWBEyOFI for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 15:06:59 +0100 (CET)
Received: from mandoch.ael.it (151.51.210.249) by smtp-out2.libero.it (7.3.120)
	id 45A397DA00543CA7 for linuxppc-embedded@ozlabs.org;
	Fri, 12 Jan 2007 15:06:59 +0100
Subject: TB5200 and GUI environment
From: Roberto Mantovani - A&L <rmantovani@libero.it>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 12 Jan 2007 15:06:56 +0100
Message-Id: <1168610816.29422.3.camel@mandoch.ael.it>
Mime-Version: 1.0
Reply-To: rmantovani@libero.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi to all,

I'm trying to install a GUI Development Environment for the TB5200
system based on ppc82xx and with a SM501 graphic device.

I'm evaluating microwindows and qt-embedded.

With Microwindows I've been able to execute the following applications
contained in the ELDK 3.1.1 dev kit:

nano-X - the graphical environment
mdemo - a microwindows demo
mtest - another microwindowsdemo app

But the graphic displayed is 'bluish', it seems there are problems with
the rgb settings.

After that I've downloaded qt-embedded-free-3.3.4 and the patch from
denx : qte-3.3.4-tqm5200-sm501.patch

I've untarred the file and applied the patch and followed build
instructions, in the compilation I get errors from the libqte lib about
the lacks of some methods from the QGfxSm501 class derived from
fQGfxRaster.


/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::drawPoints(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::processSpans(int,
QPoint*, int*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `non-virtual thunk [nv:-2344] to
QGfxRaster<(int)32, (int)0>::processSpans(int, QPoint*, int*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::tiledBlt(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::drawThickPolyline(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::drawPolygon(QPointArray const&, bool, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::setSource(unsigned
char*, int, int, int, int, unsigned*, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::drawPolyline(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::drawLine(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::stretchBlt(int, int,
int, int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::setSource(QImage
const*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::fillRect(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::setSource(QPaintDevice const*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::blt(int, int, int,
int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::scroll(int, int,
int, int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::drawPoints(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::setSource(QPaintDevice const*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::drawThickLine(int,
int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::drawPoint(int,
int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::drawLine(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::blt(int, int, int,
int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `non-virtual thunk [nv:-2344] to
QGfxRaster<(int)8, (int)0>::processSpans(int, QPoint*, int*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::stretchBlt(int,
int, int, int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::scroll(int, int,
int, int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::fillRect(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::drawPolyline(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::drawThickPolyline(QPointArray const&, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::tiledBlt(int, int,
int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::drawPolygon(QPointArray const&, bool, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::processSpans(int,
QPoint*, int*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::~QGfxRaster
[not-in-charge]()'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32,
(int)0>::QGfxRaster[not-in-charge](unsigned char*, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::drawThickLine(int,
int, int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::drawPoint(int, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8, (int)0>::~QGfxRaster
[not-in-charge]()'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::setSource(QImage
const*)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)32, (int)0>::setSource(unsigned
char*, int, int, int, int, unsigned*, int)'
/opt/eldk/ppc_6xx/home/roberto/qt-embedded-free-3.3.4/lib/libqte.so:
undefined reference to `QGfxRaster<(int)8,
(int)0>::QGfxRaster[not-in-charge](unsigned char*, int, int)'

Are there any who has succesfully compiled and used the Qt-embedded
environment ?

There are other options to have a simple GUI development environment ?

Best Regards
-- 
Roberto Mantovani <rmantovani@automazionelogistica.it>
A&L Automazione e Logistica www.automazionelogistica.it
Via del Lavoro, 13
48011 - Alfonsine - RA
Tel. 0544-866819 - Cell. 3492174955
