Return-Path: <rsc@pengutronix.de>
Date: Sun, 18 Nov 2007 12:17:16 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20071118111716.GK11448@pengutronix.de>
References: <200711150713.28211.sr@denx.de>
	<20071118004301.475BC247F1@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071118004301.475BC247F1@gemini.denx.de>
Subject: Re: about uImage-DENX-v2.6.14 config
Cc: linuxppc-dev@ozlabs.org, zhangwei zhang <linda.zhangwei@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 18, 2007 at 01:43:01AM +0100, Wolfgang Denk wrote:
> In message <200711150713.28211.sr@denx.de> Stefan Roese wrote:
> > On Wednesday 14 November 2007, zhangwei zhang wrote:
> > > Hello, I have a problem when using linux-2.6.14(download from
> > > ftp.denx.de) for RTAI on ppc440EP.
> >
> > RTAI on PPC? I thought RTAI was dead for anything other than X86.
>
> Stefan is right.
>
> RTAI is dead.
>
> You should use Xenomai instead.

Or rt-preempt of course, which is the mainline way of doing realtime.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
