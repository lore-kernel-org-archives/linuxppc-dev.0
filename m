From: Brad Boyer <flar@marcus.pants.nu>
Message-Id: <199908181746.KAA03079@marcus.pants.nu>
Subject: Re: [Fwd: Latest version of CPU emulator] (fwd)
To: Geert.Uytterhoeven@cs.kuleuven.ac.be (Geert Uytterhoeven)
Date: Wed, 18 Aug 1999 10:46:06 -0700 (PDT)
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9908181108400.985-100000@mercator.cs.kuleuven.ac.be> from "Geert Uytterhoeven" at Aug 18, 99 11:09:19 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> Perhaps Gabriel's 486SX emulator can be included as an optimization?

I doubt it, from what I know of both emulators.  The one that was submitted
for Wine is protected mode only, and Gabriel's is real mode only.  I
imagine the ideas and some of the code from Gabriel's emulator could
be adapted to this use, but it definitely couldn't be used without
some major changes.  It might be a good place to start, tho.

		Brad Boyer
		flar@pants.nu


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
