Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5CCA167A00
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 18:37:46 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Apr 2006 17:52:31 PDT."
	<20060429005231.GH458@smtp.west.cox.net>
Date: Sat, 29 Apr 2006 10:37:43 +0200
Sender: wd@denx.de
Message-Id: <20060429083743.64CA7353A56@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20060429005231.GH458@smtp.west.cox.net> you wrote:
>
> > In my understanding, 1. is with a shim; 2. is loading a separate  dtb
> > (probably  as  multi-file  image), and 3. is when U-Boot provides the
> > dtb. Am I missing something?
> 
> I'm suggesting that we make 2 easier.  U-Boot needs the file mkuimage'd
> anyways.  Why not make it easier and make adding the dtb part of that
> step instead of a seperate load?  It's still quite easy to replace if
> you're testing new dtb's out.

But that's what I'm trying to  tell  you  all  the  time.  An  U-Boot
multi-file  image is a single file (=no separate load) which combines
several files (similar to a  tarball),  here  the  kernel  +  dtb  (+
eventually ramdisk).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Shakespeare's Law of Prototyping: (Hamlet III, iv, 156-160)
        O, throw away the worser part of it,
        And live the purer with the other half.
