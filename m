From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>, <linuxppc-dev@lists.linuxppc.org>,
	<linuxppc-commit@fsmlabs.com>
Subject: Re: PVR hell
Date: Wed, 28 Mar 2001 13:46:34 +0200
Message-Id: <20010328114634.7871@mailhost.mipsys.com>
In-Reply-To: <3AC179EB.C77A2EB5@mvista.com>
References: <3AC179EB.C77A2EB5@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The only 7450 systems running Linux today are embedded PPMC with a DINK
>boot rom that boot from flash........those aren't desktops.  Someday
>Apple may have something available for you desktop guys, but the
>initial development is for Linux embedded targets :-).
>
>I think your table lookup stuff is just fine, and I'm ready to rewrite
>some of head.S to use something different.

Heh, there are already Apple G4s with the 7450 AFAIK ;)

I'll code something today in my rsync tree and post a patch that can
be discussed before pushing.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
