To: zburgess@redsonic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel 2.4.4 TQM823L boot problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Aug 2001 12:12:46 PDT."
             <200108021212.AA3393323056@redsonic.com>
Date: Thu, 02 Aug 2001 22:14:29 +0200
Message-Id: <20010802201434.E594410CB1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200108021212.AA3393323056@redsonic.com> you wrote:
>
> Using the supplied monitor, MON8xx, I can successfully download and
> start the 2.2.13 kernel (dl'd from denx.de).  However, I cannot get the
> 2.4.4-2001-05-12 kernel to go.  It appears to download without any

The old MON8xx monitor is obsolete and has been replaced by our  much
more powerful Open Source firmware "PPCBoot". Current kernel versions
don't support the old monitor any more.

Get and install PPCBoot instead - but be careful, especially when you
don't have a BDM debugger to re-program the flash.

Let me know when you need instructions.

> In perusing the archives, I found that last october, the 2.4.0-test5 kernel was running strong. I assume that the 2.4.4 is known to work by now.

Sure. And a lot of work was done for 2.4.x.

It's just that we don't support the old MON8xx any more.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It is easier to port a shell than a shell script."      - Larry Wall

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
