From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hubert Figuiere <hub-linux-ppc@trantor.staff.proxad.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1064493093.17039.44.camel@trantor.staff.proxad.net>
References: <1064493093.17039.44.camel@trantor.staff.proxad.net>
Message-Id: <1064497450.702.12.camel@gaston>
Mime-Version: 1.0
Date: Thu, 25 Sep 2003 15:44:11 +0200
Subject: Re: kernel panic in slab.c
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-09-25 at 14:31, Hubert Figuiere wrote:
> Hi,
>
> I'm getting kernel panics (during boot up or 5 minutes after, it depends
> of the wind, the external temperature, or how old is the captain ;-) )
> when I activate CONFIG_SLAB_DEBUG.
>
> Here is the output:
> kernel BUG at slab.c:1263!
> Oops: Exception in kernel mode, sig: 4
>
> Anybody have had the same problem ?
> Disabling DEBUG is fine, but I was really wondering why I was getting
> this.
>
> kernel is linux-2.4-devel BK tree in version 2.4.23-pre5

Hi Hubert !

Nice to see you using Linux again :)

What machine is this ?

The bug shows that the poison checker found that a freed block got
overriden. It didn't display more infos about the kind of pattern
it found and/or a backtrace ? That would be helpful.

I've been trying to track down such kind of memory corruption for
some time now, so if you have a good handle on it, I'm interested,
as I suspect something wrong is going on in recent 2.4s

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
