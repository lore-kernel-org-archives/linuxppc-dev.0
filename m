Date: Thu, 22 Feb 2001 08:59:48 +0000
Subject: Re: Timing Facilities
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Steve Poole <sp@is2-isnot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010222085859.0271CDB9E0@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thu, Feb 22, 2001,Joseph P. Garcia wrote:
> On Wed, 21 Feb 2001 23:24:57 -0600, Steve Poole <sp@is2-isnot.com> wrote:
>> I have written a small assembly fragment to read the TB register that runs
>> under Linux (YDL/BLL). What is the definition of a "tick" or "jiffie" under
>> Linux. When some code is run under MacOS (400MHz G4) the results are
>> *faster* (the numbers returned are lower) than when I run on a 500MHz G4. I
>> appreciate any input.
>
> I beleive there are 1*HZ jiffies in one second.  Used in the kernel's
> timer_list struct (to name one use), which basically has the kernel run a
> function at a specific time.  ex, setting the 'expires' value to (jiffies +
> HZ) will cause it to run one second from now.

the VEA TB rate is not fixed to the processor clock - but is related to the
bus freq (IIRC).  You can find the TB rate from OF (but beware of a report
that says the values stored are not always correct).

I did a similar thing a while ago - and, because high precision was not
required, just used gettime() and a few seconds sleep... to calibrate.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
