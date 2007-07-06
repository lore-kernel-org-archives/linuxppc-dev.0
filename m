Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	by ozlabs.org (Postfix) with ESMTP id 3105CDDFF4
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 05:33:22 +1000 (EST)
Date: Fri, 6 Jul 2007 21:04:56 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Too verbose compat_ioctl messages?
Message-ID: <20070706190456.GC8174@one.firstfloor.org>
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
	<468E6E33.3040000@zytor.com> <p737ipd1jsg.fsf@bingen.suse.de>
	<468E8B07.2030404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <468E8B07.2030404@goop.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 06, 2007 at 11:33:43AM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >"H. Peter Anvin" <hpa@zytor.com> writes:
> >  
> >>For one thing, it looks like we're returning the wrong thing (EINVAL
> >>rather than ENOTTY) across the board.  This was unfortunately a common
> >>misunderstanding with non-tty-related ioctls in the early days of Linux.
> >>    
> >
> >ENOTTY is so excessively misnamed that it is actually surprising
> >anybody ever got that "right" (for very small values of right i guess)
> >  
> 
> But it *isn't* a typewriter. 

Most ioctls are not related to ttys in any way.

-Andi
