In-Reply-To: <Pine.LNX.4.10.9911122147590.22175-100000@simul.biophys.uni-duesseldorf.de>
Date: Fri, 12 Nov 1999 22:00:20 +0100
To: Michael Schmitz <schmitz@simul.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: 2.3.27 on CHRP Longtrail
Message-Id: <19991112220020.007302@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 12, 1999, Michael Schmitz
<schmitz@simul.biophys.uni-duesseldorf.de> wrote:

>Please do. I tried to use xmon_printf for this very purpose on my Lombard
>with 2.3.13 with no success. 

You can do this currently if you have a recent version of xmon (I don't
remember when Paul actually changed xmon to use the early boot text).
Boot with BootX (with no video driver). Make sure the init code in
arch/ppc/xmon/start.c will map the fb and use prom_print().

I've just added the capability to do this when booting from Open Firmware.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
