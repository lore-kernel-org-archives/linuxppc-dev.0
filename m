Date: Mon, 20 Mar 2000 09:55:51 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: jingai <jingai@floatingpenguins.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: YUP and RPM dependencies
In-Reply-To: <200003180622.BAA20354@shell.faradic.net>
Message-ID: <Pine.LNX.4.10.10003200949070.433-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 17 Mar 2000, jingai wrote:

...snip...
> .so, my question is, is there a way to bypass this check (a force option
> or somesuch)?  And if not, if anyone from  the YD team is here, please make
> this an option.
...snip...

I have thought about adding a dep-check disable switch, although, the
dependency failures would re-surface after the new list of
installed packages is put together.  Another option would be to purposely
ignore dependency problems that exist on the installed system.
Unfortunately, this could cause all sorts of strange problems that I'd
rather not have to mess with.  For now, I think it is best that running
systems remain dependency sane.  This may mean removing the kernel-headers
require from glibc which I believe is the case with CS-1.2.

Stephen

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Workstations and advanced, Parallel Solutions
 http://www.blacklablinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
