Mime-Version: 1.0
Message-Id: <p04330100b7f7fdcc2099@[24.163.33.28]>
In-Reply-To: <p04330100b7f7f805ef9a@[24.163.33.28]>
References: <p04330100b7f7f805ef9a@[24.163.33.28]>
Date: Sun, 21 Oct 2001 00:25:25 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.13-pre5 crash when mounting proc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>6500, Linux/PPC 2KQ4 running 2.2.19, I compiled 2.4.13-pre5, rsynced
>from bk yesterday. On boot, when it gets to "mounting proc
>filesystem," I get a break into the mon debugger, but I have no
>keyboard response (so no backtrace). The info I can copy is:
>
>vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0
>
>plus some more that I'm not sure will help much. For this output
>alone, should I include System.map also?
>
>Is this a known problem?

I've just found the same result on a quite-different machine: Power
Mac 9500 with G3 upgrade.

On both the 6500 and the 9500, I usually make a number of small mods
to the compile (compile sound in instead of module, turn off video
and ethernet drivers I don't need, turn off USB modem and PPP, stuff
like this), but I can't be totally sure I haven't turned something
important off because I didn't write it all down...

I've never seen a freeze at the proc filesystem mount. What should I
look for to fix this?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
