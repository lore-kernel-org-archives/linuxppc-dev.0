Date: Thu, 17 Oct 2002 09:13:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: leeyang <leeyang@ycig.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 rtc problem
Message-ID: <20021017161329.GK695@opus.bloom.county>
References: <000901c27583$b24224c0$fc00a8c0@ycigrnd.ycig.com> <Pine.LNX.4.44.0210171651120.2469-201000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0210171651120.2469-201000@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 17, 2002 at 05:02:23PM +0100, Alex Zeffertt wrote:
> On Thu, 17 Oct 2002, leeyang wrote:
>
> Hi,
>
> I've written a rtc driver for the mpc860.  See attached files.
>
> HOWTO BUILD
>
> 1.	Edit KERNEL_DIR in Makefile
> 2.	make   (builds rtc.o and rtc)

This appears to be a binary file.  And the easiest way to do this is to
make ppc_md.set_rtc_time / ppc_md.get_rtc_time point to functions which
do what their name implies.  Then enable CONFIG_PPC_RTC

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
