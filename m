Message-ID: <937610FE9B70D511B3E700508B8B65770E53CA@MAIL1>
From: Shie Erlich <shie_e@elbit.co.il>
To: "Linuxppc-Embedded mailing list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: 64 bit memory access - again ...
Date: Mon, 3 Dec 2001 13:14:43 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


( i know this has been talked about before, but i couldn't get
  a complete answer from reading the posts, so ... )

i'm porting linux to a powerPC750 and have the following problem:
we have a piece of hardware whose memory region can only be
written or read to using 64bit memory access.
(i know it's a bad design, but as usual, it's not up to me ;-)

as far as i know, there are 2 ways to do a 64bit access on a 750:
1) use the FPU and do a floating point access
2) something about using a cache line and flushing it (don't know
   anymore about this one)

i also know that floating point in the kernel is a big NO, but if no other
choice is found, i'll have to do it. my questions are:

a) what is the recommended way of doing a 64bit access in the linux kernel ?
b) if the fpu is the way to go, what do i need to do so that the kernel does
not
    trap my floating point access ? details here would be greatly
appriciated ;-)


any help anyone can offer will be great,

                            thanks
 			shie erlich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
