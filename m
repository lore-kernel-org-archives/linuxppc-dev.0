Date: Fri, 11 Jul 2003 11:14:13 -0400
From: Kent Borg <kentborg@borg.org>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Heretical Question
Message-ID: <20030711111413.A6059@borg.org>
References: <D73A25AA6E54D511AD74009027B1110F3C0927@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C0927@ORION>; from BlakesleeS@embeddedplanet.com on Wed, Jul 09, 2003 at 04:09:01PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 09, 2003 at 04:09:01PM -0400, Steven Blakeslee wrote:
> ddd will let you specify a gdb debugger to use. You have to add -g -ggdb to
> the CFLAGS and compile the kernel.  Then give the command
>
> ddd --debugger ppc_8xx-gdb vmlinux
>
> Replace ppc_8xx-gdb with your debugger of choice, gdb is the default if you
> do not specify.

Yes, that works.  Thanks.


But it isn't as nice as I had hoped.  The display feature chews up
lots and lots of screen space, and little things like clicking on
something that began with "/x" fails, making it hard to browse values
in hex.  I was starting to get the hang of how to sort of use it when
I realized that I could do better with gdb inside emacs.  Hmmm.  I'll
have to try insight next.


-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
