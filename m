Message-Id: <200011271726.eARHQOC06036@denx.local.net>
To: Tom Armistead <tarmiste@phx.mcd.mot.com>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860-T / FEC transmits each packet 3 times? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 27 Nov 2000 09:57:28 MST."
             <3A229278.C774FB4@phx.mcd.mot.com>
Date: Mon, 27 Nov 2000 18:26:24 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A229278.C774FB4@phx.mcd.mot.com> Tom Armistead wrote:
>
>    I experienced the same behaviour when I had initialized the FEC to
> use only 1 transmit BD (it was a simple application and I only needed 1
> transmit buffer).  I modified the code to use 2 transmit BD's and the
> problem went away.  If you are using only a single transmit BD, try
> increasing it to 2.

Thank you very much - that was exactly the problem I had.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Status quo. Latin for "the mess we're in."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
