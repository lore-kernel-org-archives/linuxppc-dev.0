Date: 2 Nov 2001 15:25:50 -0000
Message-ID: <20011102152550.14933.qmail@mailweb16.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dag Nygren" <dag@newtech.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: EPIC Vs OpenPIC Vs MontaVista
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
>
> Funny you should write about this.!
> I am just trying to fix it in a reasonable way
> for my EPIC-board.

:-) Oh really ! Good. Since I am new to the group
I dint know its an existing bug ! but how can
one tolerate populating reserved areas ? That
sounds very dangerous to me !

> I would like to suggest a global variable ie.
> OpenPIC_RegOffset
> which would be inited to 0 and could be changed to
> 16 for a MPC107 (EPIC).
> This wouldn't (shouldn't) break anything existing
> and will enable the port of a EPIC-board to use
> all the generic openpic routines.
>
 Yeah there are plenty ways u could solve. The
best one is padding 0x200 bytes to the "OpenPIC"
structure before "Source" in case of CONFIG_SANDPOINT.
That should end the story !

> Even if I don't like touching "generic" code, I even
> more dislike code-duplication
>
> I could submit the patches, if your are interested,
> they are noe too big, and a review from the masses
> should do the code good.
>
> BRGDS
 I think I can fix it myself. Thanks for the offer.
Good Luck !

Sarnath, the NATH ;-)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
