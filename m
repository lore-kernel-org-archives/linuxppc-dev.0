Message-ID: <20030507155215.73920.qmail@web41504.mail.yahoo.com>
Date: Wed, 7 May 2003 08:52:15 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: problem in booting kernel
To: Anil Giri <anil@india.tejasnetworks.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1052296323.3eb8c48351184@pop-mail.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
>From the inuts u have given it is very tough to find
out. But let me ask u some of the questions.

1. One possiblity is that ur serial port is not
configured properly & u are not seeing any message
from the console port.

2. IF u are having the JTAG debugger find out the
value in Program conuter & see where it matches in
System.map.

So tell me the PC value then it might be possible to
catch the problem

Thanx
Bhupi
Linux+Hypertransport -->Silicon
www.gdatech.com
Good after beer ---Linux


--- Anil Giri <anil@india.tejasnetworks.com> wrote:
>
> Hi,
>
>
>    I m trying to boot kernel for linux-2.4.18
> (MPC860 processor), but it
>
>
> hangs after "Now booting the kernel"  message. What
> could be the reason???
>
>
> also on debugging i found negative value for
> register R3 instead of ptr to
>
>
> board info data. Other register settings were ok.
>
>
> Any imputs...
>
>
>
>
> -Anil
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
