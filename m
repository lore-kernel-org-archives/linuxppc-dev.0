Message-ID: <3B814CFC.23A3C030@mvista.com>
Date: Mon, 20 Aug 2001 10:46:36 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: program counter...
References: <20010817171437.97580.qmail@web20003.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Raghava Raju wrote:
>      I was unable to find the registers for
>   program counter,stack pointer. Which registers
>   I should use to access these values in powerpc.

Er, there isn't really an program counter register that you can read.
The only way I know to find it out the value of the internal "Next
Instruction Address" is to do a bl and then look at the LR (link
register) before doing a blr.

As far as the stack pointer goes, the PowerPC ABI (Application Binary
Interface) states that gpr1 should be used as the stack pointer and
therefor, it is...

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
