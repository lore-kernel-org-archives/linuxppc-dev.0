Message-ID: <XFMail.990223072246.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.05.9902220928100.405-100000@localhost.erols.com>
Date: Tue, 23 Feb 1999 07:22:46 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Tom Vier <thomassr@erols.com>
Subject: RE: egcs-1.1.1-1c bug (was Re: major ksyms problem)
Cc: linuxppc-dev@lists.linuxppc.org, mklinux-setup@public.lists.apple.com,
        mklinux-development-system@public.lists.apple.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 22-Feb-99 Tom Vier wrote:
> 
> it's an egcs bug. i think it's not aligning instructions properly, cuz
> i believe the 601 is more strict about alignment. is anyone having
> problems using bsd_comp.o, ppp_deflate.o, and hfs.o on a non-601
> machine built under pre-R5 (egcs-1.1.1-1c)?
> 
> i rebuilt bsd_comp.o and ppp_deflate.o w/ egcs-1.0-2e from dr3 and
> they worked perfectly.
> 
> egcs-1.1.1-1c failed using -O0, -O2, and -O3 with all combinations of
> -mcpu=601, -mcpu=604, and -fno-schedule-insns. -fpic did work, however
> it addes an offset table symbol that makes insmod complain.
> 
> is this a know problem?
> 
>> > Feb 21 09:36:18 zero insmod: /lib/modules/2.0.37-osfmach3/net/bsd_comp.o:
>> > Unhandled relocation of type 26 for .L343
> 

I think you need newer binutils to fix this.  Try using:
  ftp://ftp.linuxppc.org/linuxppc/users/gdt/redhat/RPMS/ppc/binutils-2.9.1-19a.ppc.rpm


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
