Date: Mon, 29 Mar 2004 13:29:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: PREEMPT on PPC
In-Reply-To: <1080556990.2441.118.camel@thor.asgaard.local>
Message-ID: <Pine.LNX.4.44.0403291329300.4088-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > What else are you using ? I suspect something like MOL may have troubles
> > with preempt for example...
>
> Not using that regularly. Not sure what's special about my setup, XFS
> maybe?
>
> What about this:
>
> -CONFIG_TASK_SIZE=0xc0000000
> +CONFIG_TASK_SIZE=0x80000000

Nope, that's what my kernel is built with as well.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
