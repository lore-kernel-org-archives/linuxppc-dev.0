Date: 11 Oct 2001 05:35:13 -0000
Message-ID: <20011011053513.17120.qmail@mailweb19.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RE: Re:How to boot linux on sandpoint board ?
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi every1,
 Thanx for quick replies. Was a good introduction.
 But I have some more doubts.
> Yes!... Linux has to be changed based on Architecure,
> and the board (chipset). And for additional devices,
> we can put in device drivers as necessary. For
> example, port for PPC is different from
> port for ARM or x86.
  Yeah,I can understand that linux for PPC is diff from
  linux for x86. But how come linux for PPC is diff
  from Linux on a sandpoint. For exp, in an IBM board,
  PIC always sits at IO addresses 0x20 and 0xA0. In any
  IBM board, whether it is for a PC or for a minimal
  board, the basic chipsets and their IO address space
  assignments (Which are hardwired, as in case of PIC,
  8254) remain the same. So, if we need to run a
  desktop OS on a minimal board, the changes involved
  would be less. This is my understanding. Correct
  me if I am wrong. Coming to point, has sandpoint
  board got some additional chipsets ? or has it got
  the same chipsets arranged in a diff way, i mean
  the address assignments. Can u list some of the
  idiosyncracies of the board ? + and -. Meanwhile
  I am also browsing archives and hunting info about
  PPC peripherals. Any pointers on this topics are most
  welcome.

  Thank you.

  Mark,
  Thanx for the suggestions. I m sure it would help me.

Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
