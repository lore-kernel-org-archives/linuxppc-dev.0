Date: Tue, 29 Jun 2004 08:09:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
In-Reply-To: <1088501514.4636.177.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.60.0406290807390.2242@localhost.localdomain>
References: <20040628104159.87EEDC109F@atlas.denx.de>
 <Pine.LNX.4.60.0406280642220.4278@localhost.localdomain>
 <1088501514.4636.177.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 29 Jun 2004, David Woodhouse wrote:

> On Mon, 2004-06-28 at 06:50 -0400, Robert P. J. Day wrote:

> Why so? JFFS2 is relatively slow to mount, and obviously _writing_ to
> flash can be slow -- but for normal operation it should be fine. Try it.
...

given that i have a few more questions (quelle surprise!) and that
they're more specifically related to filesystems and JFFS2, i figure i
might as well move this to the MTD mailing list.  it's getting a bit
off-topic for a PPC list.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
