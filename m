Date: Wed, 8 Jan 2003 23:15:35 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Status of linuxppc_2.5
To: panto@intracom.gr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3E1BECD2.9060909@intracom.gr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18WOU9-00009Z-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Jan, this message from Pantelis Antoniou echoed through cyberspace:
> I'm trying to compile linuxppc_2.5
> and the following patch is needed to
> make it compile.

Tried to compile my standard kernel compile a while back, and found the
following things broken (didn't have time to try fixing yet...):

- 53c94 Mac SCSI
- Matroxfb

I also didn't try very hard to compile in face of these problems; there
may be others still.

Sorry I can't provide more info, but maybe this discussion makes ore
people interested in 2.5 status, where I think a number of PPC-related
things need to be seriously looked at, hopefully before it is declared
2.6...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
