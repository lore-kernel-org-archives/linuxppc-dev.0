Message-ID: <38581658.A9BAE144@ctam.com.au>
Date: Thu, 16 Dec 1999 09:29:44 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Jesper Skov <jskov@cygnus.co.uk>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <ot66y035bv.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jesper Skov wrote:

> >>>>> "Brendan" == Brendan Simon <bsimon@ctam.com.au> writes:
> Brendan> After undefining it, the kernel got further.  It gets to the
> Brendan> point where it tries to run /bin/sh and then just sits there.
> Brendan> Here is the last part of the console ouput.  Any ideas where
> Brendan> to go from here.
>
> Which version of GCC do you use for compiling the kernel? Did you by
> any chance upgrade GCC recently?

I'm still using egcs-1.1.2 but I don't really see that as being the
problem.  I do want to upgrade to gcc-2.95.2 at some stage but not until
I've got a minimal linux system running that I can ping from the outside
world.  Telnet would be good too.  Once I'm there then I will upgrade my
tools.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
