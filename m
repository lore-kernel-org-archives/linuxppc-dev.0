Date: Mon, 22 Oct 2001 15:44:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Ray <g4tinker@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: idebus=133 ?
Message-ID: <20011022154453.A6673@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011022131938.21190@smtp.adsl.oleane.com> <20011022181106.29532.qmail@web13107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011022181106.29532.qmail@web13107.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 11:11:06AM -0700, Dave Ray wrote:


> Thanks for the replies. The reason I ask is that when
> I use "idebus=66" in the boot argument, the syslog
> shows bootup message "using 66MHz bus speed.." rather
> than "assuming 33MHz bus speed..".

Because you overrode it, that's why. :)  I don't think the kernel ever
tries to check things that the user tell it.

> So I assumed the
> inclusion of the boot argument sped up the computer.
> Are the appearances of these messages in the syslog
> fictitious? Or should I simply not go over 66?

You shouldn't change it at all.  Again, this has to do with the speed of
the PCI bus, _not_ weather it's ATA/33, ATA/66, ATA/100, and not the
speed of the memory bus.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
