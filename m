Date: Sun, 21 Jan 2001 22:28:42 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc_commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
Message-ID: <20010121222842.A27103@altus.drgw.net>
References: <3A68F7A0.693639F1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A68F7A0.693639F1@mvista.com>; from dan@mvista.com on Fri, Jan 19, 2001 at 09:27:44PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 19, 2001 at 09:27:44PM -0500, Dan Malek wrote:
>
> I just heard about the bug Tom Gall fixed in "context_overflow"
> by testing for current->mm == NULL.
>
> I believe the proper solution is to use 'current->active_mm'
> instead of 'current->mm' (and you never get a null pointer).
> This way, the proper 'active' context is updated with a new
> context even though a kernel thread has stolen it from somewhere
> else to use.  I think skipping the selection of a new context
> in this case could be logically incorrect for some PowerPC cores.

Since this got no response, I'm cross-posting to linuxppc-commit.

So, does anyone else have any comments on this? This appears to be something
that's going to be quite hard to track down if we don't get it right..
So what's the right answer before we forget about it again and go on?

And on that note... what do we have for bug-tracking systems for ppc kernel
related stuff? The collective memory of people on these to mailing lists?
I know someone mentioned a sourceforge page at one point.. is anyone useing that?

--
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
