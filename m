Message-ID: <3A5C9504.7DFA72DA@alerton.com>
Date: Wed, 10 Jan 2001 08:59:48 -0800
From: Bill Roman <roman@alerton.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock?
References: <Your message of "Wed, 10 Jan 2001 10:56:58 EST." <4.3.2.20010110104647.00baee80@falcon.si.com> <4.3.2.20010110114302.00ba2830@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:

> If you tracked down some references (NTP source code, NTP RFCs, "David
> L. Mills' clock adjustment algorithm"), I suspect you would be able to
> figure out how to properly use adjtimex().  Further, I suspect
> adjtimex() a pretty lightweight routine since it merely adjusts the
> parameters that presumably already exist in your kernel.
>
> I'm just leaving the fun parts for the reader :-).

Network Time Synchronization Project : http://www.eecis.udel.edu/~mills/ntp.htm


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
