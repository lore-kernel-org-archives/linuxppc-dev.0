Message-ID: <000901c27583$b24224c0$fc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 860 rtc problem
Date: Thu, 17 Oct 2002 10:19:59 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all!
HW:860T custom board
SW:devel kernel 2.4.20-pre7 nfs mount on eldk

Problem:Can not adjust time in linux shell(with 'date -s' command)

RTC really runs when I use 'date' it says sometime around 1970's
and it runs when power up.
With 'date -s' command it returned time had been changed.
However after a reset,the time go back to 1970's again :-(

I try with 'hwclock' and it says below:

bash-2.04# hwclock --debug
hwclock 2.4c/util-linux-2.11f
Using /dev/rtc interface to clock.
Last drift adjustment done at 0 seconds after 1969
Last calibration done at 0 seconds after 1969
Hardware clock is on unknown time
Assuming hardware clock is kept in local time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time from
/dev/rtc to change
...got clock tick
Time read from Hardware Clock: 1970/01/09 21:28:28
Hw clock time : 1970/01/09 21:28:28 = 786508 seconds since 1969
Fri Jan  9 21:28:28 1970  -0.188839 seconds


I guess it never really write value to RTC reg!!!
Hope help!

ps:I open /dev/rtc option in the kernel.

Regards!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
