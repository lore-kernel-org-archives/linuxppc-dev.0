Message-ID: <37BC448C.8F31800B@tin.it>
Date: Thu, 19 Aug 1999 19:53:16 +0200
From: Alberto Vignani <vignani@tin.it>
Reply-To: vignani@tin.it
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: weigand@informatik.uni-erlangen.de
Subject: Re: [Fwd: Latest version of CPU emulator] (fwd)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Wed, 18 Aug 1999 Brad Boyer <flar@marcus.pants.nu> wrote:

>Geert Uytterhoeven wrote:
>> Perhaps Gabriel's 486SX emulator can be included as an optimization?
>
>I doubt it, from what I know of both emulators.  The one that was submitted
>for Wine is protected mode only, and Gabriel's is real mode only.  I
>imagine the ideas and some of the code from Gabriel's emulator could
>be adapted to this use, but it definitely couldn't be used without
>some major changes.  It might be a good place to start, tho.
>

dosemu (www.dosemu.org) has an x86 emulator derived from the one in Twin
(www.willows.com). I am now testing the Twin version on the iMac and the
results are already very encouraging, the emulator is quite fast and has
no endianness problems AFAIK.
However, the Twin emulator does 16-bit protected mode only. But the dosemu
version can do almost all, from real mode to 32-bit DPMI. GDT,LDT and
paging have already been implemented, even if not yet fully debugged.
The dosemu version is at http://www.dosemu.org/~alberto.

Alberto

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
