Date: Tue, 23 Feb 1999 07:24:39 -0500 (EST)
From: Tom Vier <nester@erols.com>
Reply-To: Tom Vier <thomassr@erols.com>
To: Gary Thomas <gdt@linuxppc.org>
cc: linuxppc-dev@lists.linuxppc.org,
        mklinux-development-system@public.lists.apple.com
Subject: RE: egcs-1.1.1-1c bug (was Re: major ksyms problem)
In-Reply-To: <XFMail.990223072246.gdt@linuxppc.org>
Message-ID: <Pine.LNX.4.05.9902230719260.2996-100000@localhost.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Feb 1999, Gary Thomas wrote:

> On 22-Feb-99 Tom Vier wrote:
> > it's an egcs bug. i think it's not aligning instructions properly, cuz
> > i believe the 601 is more strict about alignment. is anyone having
> > problems using bsd_comp.o, ppp_deflate.o, and hfs.o on a non-601
> > machine built under pre-R5 (egcs-1.1.1-1c)?

> > egcs-1.1.1-1c failed using -O0, -O2, and -O3 with all combinations of
> > -mcpu=601, -mcpu=604, and -fno-schedule-insns. -fpic did work, however
> > it addes an offset table symbol that makes insmod complain.
> > 
> > is this a know problem?

> I think you need newer binutils to fix this.  Try using:
>   ftp://ftp.linuxppc.org/linuxppc/users/gdt/redhat/RPMS/ppc/binutils-2.9.1-19a.ppc.rpm

no, it's an egcs bug, i believe. i'm already running
binutils-2.9.1.0.19a-1a from the current pre-R5. i'm download those
egcs rpms from your dir, right now, which fred bacon told me have
VTABLE_THUNKS disabled.

--
Tom Vier - 0x82B007A8
thomass@erols.com        | goto the Zero Page at:
Tortured Souls Software  | http://www.erols.com/thomassr/zero/




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
