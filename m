Date: Sat, 21 Apr 2001 19:23:55 -0700
From: Kevin Buettner <kev@illusions.com>
Message-Id: <1010422022355.ZM3426@localhost.localdomain>
In-Reply-To: Craig Rodrigues <rodrigc@mediaone.net>
        "gdb hardware breakpoints under Linux PPC?" (Apr 21,  4:51pm)
References: <20010421165121.B7985@mediaone.net>
To: Craig Rodrigues <rodrigc@mediaone.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb hardware breakpoints under Linux PPC?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Apr 21,  4:51pm, Craig Rodrigues wrote:

> Does gdb 5 support hardware watchpoints under Linux PPC?

No.  GDB doesn't (at the moment anyway) have support for hardware
watchpoints on Linux/PPC.  It would be possible to implement this
support, be it would be necessary to have kernel support in place
first...

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
