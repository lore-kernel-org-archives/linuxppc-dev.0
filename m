Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu>
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain
Message-Id: <1065823660.601.0.camel@gaston>
Mime-Version: 1.0
Date: Sat, 11 Oct 2003 00:07:40 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-10-10 at 23:56, Ken Offer wrote:
> Hi all,
>
> Any of you know a kernel version or version of the radeonfb driver that
> supports the "ATI Mobility Radeon 9600" chip in the new 15" Powerbooks?
>   We've got one in house but the YDL 3.0.1 2.4.22-2a kernel doesn't seem
> to support it beyond text-mode.  X11 can't start up.

I just fixed that in my 2.6 and I'll backport to 2.4 soon

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
