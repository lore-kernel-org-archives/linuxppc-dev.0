To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: leeyang <leeyang@ycig.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 rtc problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "17 Oct 2002 09:24:11 CDT."
             <1034864663.8254.19.camel@granite.austin.ibm.com>
Date: Thu, 17 Oct 2002 17:42:31 +0200
Message-Id: <20021017154236.9C142FAA7@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1034864663.8254.19.camel@granite.austin.ibm.com> you wrote:
>
> > With 'date -s' command it returned time had been changed.
> > However after a reset,the time go back to 1970's again :-(
...
> `hwclock` with no arguments seems to be the same as `hwclock --show`. I
> would recommend `hwclock -w`.

hwclock expects a standard /dev/rtc interface, which is not available
for the MPC8xx in some versions of the Linux kernel.

If you're  looking  for  an  implementation,  check  out  our  kernel
sources. It includes a MPC8xx RTC driver.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is  a  nanocentury.
                                               -- Tom Duff, Bell Labs

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
