Mime-Version: 1.0
Message-Id: <p04330100b6cabf67a3e4@[38.205.4.5]>
In-Reply-To: <20010306151708.54D722EFB4@apollo.valhalla.net>
References: <20010306151708.54D722EFB4@apollo.valhalla.net>
Date: Tue, 6 Mar 2001 11:24:36 -0500
To: "Iain Sandoe" <iain@sandoe.co.uk>,
	linux <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > 1. I get a "mon>" prompt on about half of the boots. And on half of
>>  those, typing "x" exits me from mon and continues the boot. The rest
>>  just hang. What is mon anyway? I've already seen reference to this on
>>  the user list, not sure what the solution is...
>
>the kernel has "oopsed" - and dropped you into xmon (debugger).  You can
>find out more by doing "?" to list the commands and getting a traceback and
>exception report.
>
>This will tell people where the problem lies.

OK, thanks.


>  > 2. No USB mouse response in X. lspci -vv, in part, gives:
>
>>  I can live with the mon, but not without my mouse. Any suggestions here?
>
>have you done the changes in /dev to accommodate the new input layer?


Yes, I was already running input layer on 2.2.18, with no problems.
AFAICT, there are no /dev changes for 2.4.2 if I had already done
them for 2.2.18, no?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
