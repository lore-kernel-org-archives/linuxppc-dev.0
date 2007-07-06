Return-Path: <jeremy@goop.org>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9D7F5DDFAF
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 05:05:28 +1000 (EST)
Message-ID: <468E8B07.2030404@goop.org>
Date: Fri, 06 Jul 2007 11:33:43 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: Too verbose compat_ioctl messages?
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>	<468E6E33.3040000@zytor.com>
	<p737ipd1jsg.fsf@bingen.suse.de>
In-Reply-To: <p737ipd1jsg.fsf@bingen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>,
	"H. Peter Anvin" <hpa@zytor.com>
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
>   
>> For one thing, it looks like we're returning the wrong thing (EINVAL
>> rather than ENOTTY) across the board.  This was unfortunately a common
>> misunderstanding with non-tty-related ioctls in the early days of Linux.
>>     
>
> ENOTTY is so excessively misnamed that it is actually surprising
> anybody ever got that "right" (for very small values of right i guess)
>   

But it *isn't* a typewriter.  Of course, it's not a giraffe either.

    J
