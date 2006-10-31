Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id E1CB667E82
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 18:52:14 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xubuntu and Xenomai on the Lite5200 (IceCube)...
Date: Tue, 31 Oct 2006 08:54:40 +0100
References: <200610301209.38103.david.jander@protonic.nl>
	<528646bc0610300958p627a79abyd84059854a8ca47@mail.gmail.com>
In-Reply-To: <528646bc0610300958p627a79abyd84059854a8ca47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610310854.40656.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 30 October 2006 18:58, Grant Likely wrote:
>[...]
>> 
> Congratulations, that's good work!  Especially the bit about
> documenting what you did!  I've been meaning to play w/ xenomai for a
> while now.

Thanks. I hope this makes searching-time shorter for you.
I wish I could remember more details about what I exactly changed to make the 
kernel compile after backporting bestcomm and FEC... I vaguely remember 
adding "#include <platform_device.h>" to at least two files...

> Care to help with the port to arch/powerpc now?  :P

I would really like to, but I have very limited time to dedicate to such 
things. If I get the chance to do something about it, I'll do it, I promise. 
The time will come when I'll have to port our own board-support stuff to 
arch/powerpc... so...

Greetings,

-- 
David Jander
