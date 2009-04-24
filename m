Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C9DD9DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 21:04:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [V5] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
Date: Fri, 24 Apr 2009 13:01:58 +0200
References: <20090417205119.3D35660055@mail16-sin.bigfish.com>
In-Reply-To: <20090417205119.3D35660055@mail16-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-00=_nwZ8JJ0oEqOGvRk"
Message-Id: <200904241301.59775.arnd@arndb.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, akonovalov@ru.mvista.com,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_nwZ8JJ0oEqOGvRk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday 17 April 2009, John Linn wrote:
> Added support for the new xps tft controller. The new core
> has PLB interface support in addition to existing DCR interface.
> 
> Removed platform device support as both MicroBlaze and PowerPC
> use device tree.

I just said in another email thread that we would need a CONFIG_DCR
option that DCR using drivers should depend on, if it ever happened
outside of powerpc.

Well, apparently this happened earlier than I expected.

Converting the driver to use the generic DCR interface
makes it possible to use in any system that provides this
interface, including those that use a hard CPU core with xilinx_fb
on an FPGA, so it makes sense to just change the dependency
in Kconfig and provide CONFIG_DCR in microblaze (unconditionally)
as well as in powerpc instead of the existing CONFIG_PPC_DCR.

	Arnd <><

--Boundary-00=_nwZ8JJ0oEqOGvRk
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans Light'; font-size:8pt; font-weight:200; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Friday 17 April 2009, John Linn wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Added support for the new xps tft controller. The new core</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; has PLB interface support in addition to existing DCR interface.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Removed platform device support as both MicroBlaze and PowerPC</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; use device tree.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I just said in another email thread that we would need a CONFIG_DCR</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">option that DCR using drivers should depend on, if it ever happened</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">outside of powerpc.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Well, apparently this happened earlier than I expected.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Converting the driver to use the generic DCR interface</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">makes it possible to use in any system that provides this</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">interface, including those that use a hard CPU core with xilinx_fb</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">on an FPGA, so it makes sense to just change the dependency</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">in Kconfig and provide CONFIG_DCR in microblaze (unconditionally)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">as well as in powerpc instead of the existing CONFIG_PPC_DCR.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	Arnd &lt;&gt;&lt;</p></body></html>
--Boundary-00=_nwZ8JJ0oEqOGvRk--
