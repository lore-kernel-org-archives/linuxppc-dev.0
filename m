Message-ID: <3CCECF5C.C56FEB6D@opensource.se>
Date: Tue, 30 Apr 2002 19:07:40 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Jakob Jepsen <JSJ@voxtream.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Strange writings at 0x0
References: <sccec3dd.067@mail.pel.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think the file arch/ppc/kernel/head_8xx.S
saves stuff on address 0 in the tlb handler.
(line 361 on 2002-03-21)

/ magnus

Jakob Jepsen wrote:
>
> Hi
>
> When tracking a bug in our own code we stumbled over some strange
> writings to addr 0x0.
>
> The pattern :
>
> 00000000 : 55 00 30 55 01 30 5e 80 00 00 00 00 00 00 00 00
>
> are written continuously to memory.
>
> The writings have in them self no effect, but must be considered a bad
> sign.
>
> We are running on a MPC857T rev. A BETA running at 50 MHZ.
> Linux version 2.4.4 from Denx
>
> Have anybody seen something like this or have anybody an idea to where
> the data are
> coming from. (The CPM is a sure guess, but what are generating it ?)
>
> Thanks.
>
> Jakob
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
