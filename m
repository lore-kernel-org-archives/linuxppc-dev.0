Date: Tue, 5 Dec 2000 19:12:29 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: alex@cosmo.allay.net
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012051221430.22364-100000@macachu.ex-pressnet.com>
Message-ID: <Pine.LNX.4.10.10012051911150.25035-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > pass [4] int: 25 string: somestring
> > Speicherschutzverletzung (core dumped)
> >
> > is what I get. On Intel, that is. gcc version is egcs-2.91.66. Seems
> > something's wrong with your code in general.
>
> well, thats the thing. there isnt, i dont think, wrong with my code (apart
> from what you said earlier (later? i get this as being 15 minutes
> "new"er). it doesnt segfault at all here. i get some screwed up variables,

I found the reason for the segfault, BTW. Please compile your test code
using the -Wall option to see for yourself.

Thanks for wasting my time.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
