Message-ID: <20011107070934.3021.qmail@dag.newtech.fi>
To: Dan Malek <dan@mvista.com>
Cc: Dag Nygren <dag@newtech.fi>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org, dag@newtech.fi
Subject: Re: RFC: i8259.c cleanup 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Wed, 07 Nov 2001 02:00:27 EST." <3BE8DC0B.80005@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 09:09:34 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Dag Nygren wrote:
>
>
> > I think my suggestion for an improvement of the open_pic() interface
> > could help you in this... I posted it on the linux_embedded list, but got
> > no comments so far.
>
> Yes, you did :-).

Sure, but that was on the i8259 stuff.
It is not in this patch, I left that one out as it
seemed like you did not like that ;-)

The patch I posted will not touch the i8259() !
It only replaces the openpic_init() function with
one that describes the openpic a little better.

Actually I think that this description could easily be
extended to something like the one you purposed.

Dag


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
