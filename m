Date: Tue, 06 Mar 2001 15:17:08 +0000
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Stefan Jeglinski <jeglin@4pi.com>,
	linux <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010306151708.54D722EFB4@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Stefan,

> 1. I get a "mon>" prompt on about half of the boots. And on half of
> those, typing "x" exits me from mon and continues the boot. The rest
> just hang. What is mon anyway? I've already seen reference to this on
> the user list, not sure what the solution is...

the kernel has "oopsed" - and dropped you into xmon (debugger).  You can
find out more by doing "?" to list the commands and getting a traceback and
exception report.

This will tell people where the problem lies.

> 2. No USB mouse response in X. lspci -vv, in part, gives:

> I can live with the mon, but not without my mouse. Any suggestions here?

have you done the changes in /dev to accommodate the new input layer?

iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
