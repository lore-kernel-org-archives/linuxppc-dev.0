Date: Mon, 10 Jul 2000 19:42:59 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: diekema_jon <diekema@bucks.si.com>
cc: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com, all@cideas.com
Subject: Re: -Werror is causing some heart ache
In-Reply-To: <m13BmoO-001SyaC@bucks>
Message-ID: <Pine.LNX.4.21.0007101936450.23855-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> In one of the recent changesets, the CFLAGS definition in ./Makefile
> was modified to add -Werror.  The -Werror option to gcc causes it to
> treat warnings are errors.

I have already complained about this to the main linux list. Warnings are
bad, but at this stage of the game it is an ordinary user recompiling the
kernel who suffers, not the sloppy developer.

Linux moves to the next stable release. What if in some configurations
some variables are defined but not used? Should we add more and more
ifdef's to fix those subtle warnings (and possibly break other
configurations without leaving the time to fix them)? I don't think so.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
