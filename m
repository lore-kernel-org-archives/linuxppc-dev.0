Message-ID: <3F725407.3020907@mvista.com>
Date: Wed, 24 Sep 2003 19:33:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Q-ha Park <qha@infoeq.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455
References: <004c01c382ff$de2da2f0$2a21a8c0@qha>
In-Reply-To: <004c01c382ff$de2da2f0$2a21a8c0@qha>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Q-ha Park wrote:

>I'm new to BDI2000, and after reading a manual that came with the tool,
>I tried to debug ppcboot using bdi2000 and gdb. The problem is I just
>can't set the breakpoint whether be it software or hardware breakpoint;
>For example, when I set the break point at "boot_cold" and type
>"continue", the program just runs without ever stopping at the
>breakpoint where it's supposed to stop!
>
>
Well, I haven't used the gdb interface with the 745x but I do know that
that with the telnet interface, you have to specify whether you're
setting a breakpoint on a virtual or physical addr (virtual is default,
IIRC).  How you would do this with the gdb interface, I know not but
take a close look at the manual for the 745x--it *is* different from the
7410, etc--and you may find the answer.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
