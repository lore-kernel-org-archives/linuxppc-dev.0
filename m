Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] PS3 improved video mode autodetection for HDMI/DVI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0707131404320.18802@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<20070712140620.GB507@ping.uio.no>
	<Pine.LNX.4.62.0707121704270.8368@pademelon.sonytel.be>
	<20070713094814.GD507@ping.uio.no>
	<Pine.LNX.4.62.0707131404320.18802@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 22:35:52 +1000
Message-Id: <1184330152.6059.221.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Since 720p is a broadcast mode, I can't make it default to fullscreen, as a
> part of the image will fall off on most monitors.

Do you have any info from the EDID block that would tell you whether the
monitor displays the full picture (typical of flat panels) or not ?

Ben.
