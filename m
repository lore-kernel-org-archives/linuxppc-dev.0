In-Reply-To: <v04003a00b3e9f623e46f@[216.81.27.143]>
Date: Thu, 26 Aug 1999 10:44:50 +0200
To: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Performa 5200
Message-Id: <19990826104450.024993@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 25, 1999, Tony Mantler <eek@escape.ca> wrote:

>I know the '040 maintains consistiency during the operation of alternate
>bus masters by snooping and spiking the bus according to what's in the
>cache. I haven't read up on how the PPC does it, but I would have expected
>it to be made code-level compatible with what the 040 does, atleast in
>these early PMacs.

I didn't check but someone (I think Paul) told me that snooping was not
done accross the PPC<->68k bus bridge used by those machines.

Note that I'm working on another cache-incoherent platform, and I'm
struggling with similar issues, I beleive we should manage to
"officialise" some vmalloc_uncached functions in the kernel for
cache-incoherent platforms (and define a standard way to tell a driver
it's running on a non-coherent machines). The current macros in io.h are
definitely not enough.
>
>Or something like that.
>
>Penguin collects a pile of LM globals and passes them in the bi struct, but
>most of those can be implied from the gestalt machine ID. Considering the
>number of NuBus PMacs, I don't think it would be terribly difficult to
>guess anything that's not passed in explicitly.

I think that's what MkLinux does.

>But, I shan't pay any note of it 'till *after* I get a kernel to boot. :)

Yep, of course ;-)


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
