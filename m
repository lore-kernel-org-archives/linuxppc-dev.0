Message-ID: <3873C65B.54932D84@execpc.com>
Date: Wed, 05 Jan 2000 16:31:55 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Naoki Takebayashi <ntakebay@bio.indiana.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: enhanced RTC and SMP on PowerMac
References: <Pine.SOL.4.10.10001051648140.262-100000@sunflower.bio.indiana.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Naoki Takebayashi wrote:
> 
> Is enhanced RTC supposed to work on PowerMac?  When I compile with
> CONFIG_RTC, the kernel doesn't boot up and dies when it hits the following
> line:
> 
>    /* Initialize periodic freq. to CMOS reset default, which is 1024Hz */
>    CMOS_WRITE(((CMOS_READ(RTC_FREQ_SELECT) & 0xF0) | 0x06), RTC_FREQ_SELECT);

I have the same problem.  I dont think it should work.  (CMOS on a ppc?)

I have noticed that the 'clock' program seems to access the rtc.  Assuming it
is, it may have the code we want to put in the kernel.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
