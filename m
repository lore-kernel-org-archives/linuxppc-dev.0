Message-ID: <3DCF62E2.89F1C882@bmrtech.com>
Date: Mon, 11 Nov 2002 15:57:22 +0800
From: sjk <jack.sun@bmrtech.com>
Reply-To: jack.sun@bmrtech.com
MIME-Version: 1.0
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver and gdb cross debug?
References: <20021111074041.EBB0127DE1@chuy.ouraynet.com>
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dr. Craig,

I am using MontaVista Linux LSP. The ibm-walnut-ppc405gp LSP works correctly
on walnut board. We can cross debug applications by ppc_405-gdb and
gdbserver(version 5.1).
But the following problem occurs on EP405 board.
Is it possible that the problem is caused by library, memory or initialization
of PPC405GP registers?

Sun

"Dr. Craig Hollabaugh" wrote:

> > I am porting Linux on EP405 board. So I use gdbserver and gdb to debug
> > applications,but only the first
> > breakpoint could be stopped.Then if i press 'step', the program will
> > execute to end straightforwardly . Any other breakpoints could not break
> > the execution.
>
> Which tools are you using? I've been using the fine ELDK from denx on a
> walnut board without problems like you mention above.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
