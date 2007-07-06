Return-Path: <ak@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22A09DE01B
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 03:19:31 +1000 (EST)
Sender: ak@suse.de
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Too verbose compat_ioctl messages?
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
	<468E6E33.3040000@zytor.com>
From: Andi Kleen <andi@firstfloor.org>
Date: 06 Jul 2007 20:14:39 +0200
In-Reply-To: <468E6E33.3040000@zytor.com>
Message-ID: <p737ipd1jsg.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"H. Peter Anvin" <hpa@zytor.com> writes:
> 
> For one thing, it looks like we're returning the wrong thing (EINVAL
> rather than ENOTTY) across the board.  This was unfortunately a common
> misunderstanding with non-tty-related ioctls in the early days of Linux.

ENOTTY is so excessively misnamed that it is actually surprising
anybody ever got that "right" (for very small values of right i guess)

-Andi
