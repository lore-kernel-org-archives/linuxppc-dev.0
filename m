Subject: Re: pmac: input layer as module and usb keyboard
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030209213031.2b67933e.damm@opensource.se>
References: <20030209213031.2b67933e.damm@opensource.se>
Content-Type: text/plain
Message-Id: <1044829048.11918.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 09 Feb 2003 23:17:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-02-09 at 22:30, Magnus Damm wrote:
> Hi all,
>
> This patch makes it possible to use a usb keyboard with a kernel that has the
> input layer compiled as a module.
>
> Please apply.

Well, I tend to hate CONFIG_*_MODULE. The kernel itself shouldn't
be affected by a subsystem or driver beeing a module that way. I
need to find out a better way to deal with this problem.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
