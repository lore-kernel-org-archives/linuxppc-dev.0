Message-ID: <37DF028E.AEE3C4EB@jlc.net>
Date: Tue, 14 Sep 1999 22:21:02 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: <sebastien_tadeoni@yahoo.fr>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem for compiling linux-2.2.5-embedded
References: <19990914142953.21439.rocketmail@web601.yahoomail.com> <37DEF30C.EFB188F6@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> Things you should NOT have included are :
> - serial support and serial-console support.  I know this sounds wrong but
> that's the way it is.


It's that way because selecting any 8xx automatically configures
a serial console. You can't get a serial console without selecting
PC-Style uarts.  You can't select PC-Style uarts on the 8xx because
they assume they are the only serial ports on a system and that
is where a console belongs.  This prevents using the 8xx CPM
serial ports.

We should change this to allow both PC uarts and the CPM uarts
to co-exist.  The only board I know of that mixes these is the
MBX, so it is low on my list of things to do.


> PS. I think there is a sample configuration file in embedded-notes.txt or
> mbx-notes.txt on the ftp site.

That is pretty out of date.  I need to create a real configuration
file that is kept with the kernel sources.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
