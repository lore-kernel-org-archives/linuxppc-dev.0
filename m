Date: Thu, 20 Jul 2000 06:56:22 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Sacha Varma <sacha@ssl.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI compatibility
In-Reply-To: <3975C772.871AA333@ssl.co.uk>
Message-ID: <Pine.LNX.4.10.10007200653360.21977-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jul 2000, Sacha Varma wrote:

> It's quite terse but states that PCI cards that need to be active on boot (video cards) will generally not work, and cards that don't generally will.
>
> I'm just curious (I was wondering why there was no support for various nifty non-AGP PC graphics cards, and also why the PC USB card I installed yesterday works fine under MacOS) but


Video cards do not need to be active 'on boot' (if you mean upon powerup)
to work in linux.  If there is no OF rom you will ofcourse not see any
display until Linux initializes the display.  If you have problems with
devices not 'talking' then try enabling IO and MEM access, as they were
probably not turned on.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
