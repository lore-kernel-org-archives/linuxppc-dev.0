Date: Mon, 8 May 2000 11:35:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: ian reinhart geiser <geiseri@msoe.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems Compileing PVM
In-Reply-To: <00050714365900.05361@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10005080915420.8539-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Sun, 07 May 2000, Michael Schmitz wrote:
> > > __va_arg_type_violation
>
> Franz once explained this error to me.  It seems according to the ANSI C
> standard va_arg can only be done with primary (promoted) types like integer,
> double, etc.  For any other type, a cast must be done to create proper ansi c.

That's what I meant by 'sloppy programming'. Your instructions cover
everything but one tiny detail: it is common practice to pass the 'args'
va_list argument to other functions further down. In some cases I've seen,
a pointer to the va_list argument is passed (which breaks on PPC). What's
the proper coding style here?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
