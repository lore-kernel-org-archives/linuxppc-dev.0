Date: Thu, 22 Feb 2001 00:10:16 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Steve Poole <sp@is2-isnot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Timing Facilities
Message-Id: <20010222001016.316ac1a3.jpgarcia@execpc.com>
In-Reply-To: <4.2.2.20010221232125.00c97100@mail.brokersys.com>
References: <4.2.2.20010221232125.00c97100@mail.brokersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 21 Feb 2001 23:24:57 -0600, Steve Poole <sp@is2-isnot.com> wrote:

>
> I have written a small assembly fragment to read the TB register that runs
> under Linux (YDL/BLL). What is the definition of a "tick" or "jiffie" under
> Linux. When some code is run under MacOS (400MHz G4) the results are
> *faster* (the numbers returned are lower) than when I run on a 500MHz G4. I
> appreciate any input.

I beleive there are 1*HZ jiffies in one second.  Used in the kernel's timer_list struct (to name one use), which basically has the kernel run a function at a specific time.  ex, setting the 'expires' value to (jiffies + HZ) will cause it to run one second from now.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
