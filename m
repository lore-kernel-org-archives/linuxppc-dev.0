To: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: init on a FADS823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Feb 2001 17:11:20 PST."
             <3A9315B8.16C9BF1@intel.com>
Date: Wed, 21 Feb 2001 09:04:04 +0100
Message-Id: <20010221080409.6FD12281D9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A9315B8.16C9BF1@intel.com> you wrote:
>
> I'm trying to get a init program to work on my FADS823.
>
> Running bash as the init process works fine. However, if I try the
...
> trying to compile simpleinit from util-linux, since I need a really
> simple solution, but it won't

If you need an "init" process and a  simple  solution  as  well,  why
don't  you use the "init" that's included with busybox? Because, when
you run "init", you will want to have some other tools  as  well,  so
busybox is probably useful in other ways, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The universe does not have laws - it has habits, and  habits  can  be
broken.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
