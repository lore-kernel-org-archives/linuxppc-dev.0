Message-Id: <5.1.0.14.2.20021023000428.02230770@mail.attbi.com>
Date: Wed, 23 Oct 2002 00:04:46 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Involking SysRq functions
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 01:47 PM 10/22/2002, you wrote:
>How do you access the SysRq functions, such as kernel backtrace, when
>running the
>serial port with a terminal emulator? (minicom)

Well, RTFM.

Documentation/sysrq.txt:

    On the serial console (PC style standard serial ports only) -
            You send a BREAK, then within 5 seconds a command key. Sending
            BREAK twice is interpreted as a normal BREAK.


How to send BREAK from minicom?

# man minicom

/BREAK

you'll find: Ctrl-A F


Enjoy.


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
