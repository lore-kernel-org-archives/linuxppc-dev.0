From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fwd: CPU features
Date: Mon, 2 Apr 2001 00:07:56 +0200
Message-Id: <20010401220756.11222@smtp.wanadoo.fr>
In-Reply-To: <v04003a01b6ed50bf1d86@[24.70.162.12]>
References: <v04003a01b6ed50bf1d86@[24.70.162.12]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>not fully up-to-date, I'll check that asap.
>
>Ok, that crash appears to be fixed now.
>
>Now after arch:exit, it just... stops. Cmd-power doesn't bring up xmon, so
>I have no idea where it's died.
>
>The sti replacement code still looked kinda weird, but I have no idea what
>it's supposed to look like, so I guess that's ok...

I'll have to look at this more closely. The problem may come from the
spinlock problem (my fix might not be enough) or from another issue
with my devel kernel as some of the new things in there have not yet
been fully tested, especially on SMP.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
