Message-ID: <20030524230241.82225.qmail@web41505.mail.yahoo.com>
Date: Sat, 24 May 2003 16:02:41 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: slow in user space?
To: John Ma <kwma@avantwave.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3ECDD7C0.80401@avantwave.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
>From the inputs u have given, looks like Interrupt are
nor settled properly. After mounting the ramdisk
console driver (serial port in ur case)starts working
in interrupt mode. If serial port interrupt are not
set properly, It will work on timer based & system
will be slow.

It may help......................

Bhupi
www.gdatech.com
Linux+Hypertransport -> Silicon
www.gdatech.com
Good after beer -- Linux

--- John Ma <kwma@avantwave.com> wrote:
>
> Hi all,
>     I have a MPC8241 board and  running ppc kernel
> 2.4.21-pre7 on it.
> Serial console is enabled and a small ramdisk is
> mounted as root.  The
> board is running at 200M Hz.  The kernel seems to be
> ok during bootup
> (just a few seconds).  But after the root filesystem
> is mounted and
> /sbin/init is started, the system becomes very slow.
>  I need to wait
> several minutes for the login console.
>     My board has no rtc.  So I assume that
> tb_ticks_per_jiffy is equal
> to be 25M/HZ (25M is the memory clock frequency).
> tb_ticks_per_jiffy
> will set the decrementer register which will control
> how long the timer
> interrupt occurs.  is it correct to set this value?
>     I have ever tried some smaller values for it and
> I found that the
> speed becomes faster.  But the time on the board
> becomes faster also
> (uptime on the board is several hours but I power on
> it just several
> minutes).
>     Does anyone have suggestions on it?
>
> Thanks.
>
> Best Regards
> John
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
