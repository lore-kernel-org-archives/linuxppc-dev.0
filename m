Message-ID: <3ECDD7C0.80401@avantwave.com>
Date: Fri, 23 May 2003 16:11:44 +0800
From: John Ma <kwma@avantwave.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: slow in user space?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
    I have a MPC8241 board and  running ppc kernel 2.4.21-pre7 on it.
Serial console is enabled and a small ramdisk is mounted as root.  The
board is running at 200M Hz.  The kernel seems to be ok during bootup
(just a few seconds).  But after the root filesystem is mounted and
/sbin/init is started, the system becomes very slow.  I need to wait
several minutes for the login console.
    My board has no rtc.  So I assume that tb_ticks_per_jiffy is equal
to be 25M/HZ (25M is the memory clock frequency).  tb_ticks_per_jiffy
will set the decrementer register which will control how long the timer
interrupt occurs.  is it correct to set this value?
    I have ever tried some smaller values for it and I found that the
speed becomes faster.  But the time on the board becomes faster also
(uptime on the board is several hours but I power on it just several
minutes).
    Does anyone have suggestions on it?

Thanks.

Best Regards
John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
