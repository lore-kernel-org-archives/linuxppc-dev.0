Date: Mon, 7 Apr 2003 10:36:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xmon and System.map
Message-ID: <20030407173604.GC16622@ip68-0-152-218.tc.ph.cox.net>
References: <19040101003658.689943ca.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19040101003658.689943ca.iweiny@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Apr 06, 2003 at 04:20:43PM -0700, Ira Weiny wrote:

> I have been trying to use xmon to help debug some things and I have not been
> able to get the System.map to show up?
>
> Here is the line I thought would load it...
>
> sysmap=/boot/System.map
>
> There is only one root partition but the System.map is a soft link.  Any
> thoughts?

This is on a pmac / yaboot then?  Perhaps it's not happy about the
symlink ('tho I wouldn't know why..) and the following may work:
image=/boot/vmlinux-xmon
	label=xmon
	sysmap=/boot/System.map-xmon
With values changed to taste :)

Or, if you do a 'make zImage' and boot the vmlinuz.elf-pmac (or so) from
OF, it should just work.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
