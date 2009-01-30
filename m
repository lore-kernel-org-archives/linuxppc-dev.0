Return-Path: <rsc@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 876E6DDF5A
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 10:06:59 +1100 (EST)
Date: Sat, 31 Jan 2009 00:06:33 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: 2.6.28-rt on PowerPC
Message-ID: <20090130230633.GG32026@pengutronix.de>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	<1233270043.3833.57.camel@localhost.localdomain>
	<49823A13.50703@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <49823A13.50703@am.sony.com>
Cc: linux-rt-users@vger.kernel.org, Uwe Kleine-Koenig <ukl@pengutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank,

On Thu, Jan 29, 2009 at 03:21:55PM -0800, Frank Rowand wrote:
> > Thanks! I have not yet had the chance to apply any arch patches yet. I
> > do plan on doing so after getting the code mostly working on x86.
> 
> Your email can at an opportune time for me...  I was starting to try
> 2.6.28-rt on ARM and quickly came to the conclusion that the arch
> patches weren't the focus yet.  But I'm currently side-tracked with
> getting my board to even boot a vanilla 2.6.28 kernel first.  Do
> you expect to get to the arches in the next week or two?  If not,
> I may head down that path for ARM myself.

Uwe has collected some patches for ARM here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/52108/focus=787937

You might want to try them before starting, in order to avoid duplicate
work.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
