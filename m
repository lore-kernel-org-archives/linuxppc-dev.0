Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 860 rtc problem
From: Hollis Blanchard <hollis@austin.ibm.com>
To: leeyang <leeyang@ycig.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000901c27583$b24224c0$fc00a8c0@ycigrnd.ycig.com>
References: <000901c27583$b24224c0$fc00a8c0@ycigrnd.ycig.com>
Date: 17 Oct 2002 09:24:11 -0500
Message-Id: <1034864663.8254.19.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-10-16 at 21:19, leeyang wrote:
>
> With 'date -s' command it returned time had been changed.
> However after a reset,the time go back to 1970's again :-(
>
> I try with 'hwclock' and it says below:
>
> bash-2.04# hwclock --debug
> hwclock 2.4c/util-linux-2.11f
> Using /dev/rtc interface to clock.
> Last drift adjustment done at 0 seconds after 1969
> Last calibration done at 0 seconds after 1969
> Hardware clock is on unknown time
> Assuming hardware clock is kept in local time.
> Waiting for clock tick...
> /dev/rtc does not have interrupt functions. Waiting in loop for time from
> /dev/rtc to change
> ...got clock tick
> Time read from Hardware Clock: 1970/01/09 21:28:28
> Hw clock time : 1970/01/09 21:28:28 = 786508 seconds since 1969
> Fri Jan  9 21:28:28 1970  -0.188839 seconds

`hwclock` with no arguments seems to be the same as `hwclock --show`. I
would recommend `hwclock -w`.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
