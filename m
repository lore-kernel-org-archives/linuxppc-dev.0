Message-ID: <3806A9A2.EC5A82D6@mondonet.net>
Date: Thu, 14 Oct 1999 21:12:18 -0700
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
References: <199910141741.TAA11374@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>  But if mincom is the only program that is unhappy with the wait, it
> sure is sufficient to fix minicom (and make the serial driver return
> -ERESTARTSYS or similar if the wait was interrupted by a signal).

What about chat ? Fixing it will give a lot of us the
possibility to use PPP via command line (which I prefer
btw :)) and, Micheal, chat seems not to work.

-- 
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
