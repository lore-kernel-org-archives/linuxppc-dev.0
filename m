To: nbasker@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: data address causing machine check exception 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Sep 2002 20:00:42 +0600."
             <1032445842.3d89df925ac65@pop-mail.india.tejasnetworks.com>
Date: Thu, 19 Sep 2002 19:08:09 +0200
Message-Id: <20020919170814.E25F9FA8E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1032445842.3d89df925ac65@pop-mail.india.tejasnetworks.com> you wrote:
>
> In my driver module, there is an invalid memory access
> that causes a machine check exception.
...
> Since the exception is caused due to load/store related
> error, I was expecting the dar register to hold the Effective
> Address of the data, but I find zero.

Why don't you belive that, then? Maybe this _is_ the probem?
Somebody trying to dereferece NULL?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It's a small world, but I wouldn't want to paint it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
