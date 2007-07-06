Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2A29DDF24
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 03:48:35 +1000 (EST)
Message-ID: <468E8064.6000107@zytor.com>
Date: Fri, 06 Jul 2007 10:48:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: Too verbose compat_ioctl messages?
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>	<468E6E33.3040000@zytor.com>
	<p737ipd1jsg.fsf@bingen.suse.de>
In-Reply-To: <p737ipd1jsg.fsf@bingen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
>> For one thing, it looks like we're returning the wrong thing (EINVAL
>> rather than ENOTTY) across the board.  This was unfortunately a common
>> misunderstanding with non-tty-related ioctls in the early days of Linux.
> 
> ENOTTY is so excessively misnamed that it is actually surprising
> anybody ever got that "right" (for very small values of right i guess)
> 

No argument there.

	-hpa
