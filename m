Date: Tue, 1 Feb 2000 15:11:12 -0500
From: brad allison <jackal@aol.net>
To: Stephen Edie <sedie@terraplex.com>
cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB problems in 2.2.14pre9
In-Reply-To: <Pine.LNX.4.10.10001251234480.13666-100000@newhope.terraplex.c
 om>
Message-ID: <Pine.SGI.4.00.10002011510110.14840-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Tue, 25 Jan 2000, Stephen Edie wrote:

> Hmm,
>
> > But I'm only pressing a maximum of _two_ keys "cd" and it's coming out as
> > "cdcd".
> >
> > It's a real pain cause I do "cd" a lot.
>
> You are probably hitting three keys:  "cd<space>"  Anyway, this problem
> occurs at the console as well as in X, however, strangely it is much worse
> at the console.
>

Oh it's driving me crazy!

# cdd -
cdd: Command not found.
# cdcd
cdcd: Command not found.
# cdcd
cdcd: Command not found.

Everyday.. over and over.

This is a bug that only affects fast typest.

-b


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
