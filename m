Message-Id: <199901100153.CAA18725@denx.muc.de>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MBX860: How to boot with initrd ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 09 Jan 1999 14:40:53 MST."
             <Pine.LNX.3.96.990109144040.12262A-100000@persephone.cs.nmt.edu>
Date: Sun, 10 Jan 1999 02:53:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.3.96.990109144040.12262A-100000@persephone.cs.nmt.edu> you write:
> How big is your initrd? Try it with a trivial one (~2k or so) and see if
> that works.

I've been playing with a 4 MB initrd (I have 36 MB of RAM on the  MBX
board). Just tried a 2kB initrd (empty, not even a filesystem in it);
but at least the kernel should boot, right? It hangs...


Hm... No luck with the latest snapshot of egcs either; it  dies  with
"Internal compiler error in function emit_move_insn_1"

But ok, the install of linuxppc-R4 on my PowerBook  is  running  with
only minor problems so far...

Ok, now I tryed this with a set of native compilers: egcs-2.90.25  as
comes with linuxppc-R4, then egcs-1.1.1, and the latest egcs-19990103
snapshot:

egcs-19990103 both cross and native: "Internal compiler error in
        function emit_move_insn_1" when compiling init/main.c (line
        2663).

egcs-1.1.1 both cross and native: compiles fine, but the kernel hangs

egcs-2.90.25 native: compiles fine, and the kernel BOOTS!!! [*All*
        configurations I failed to get running with the other
        compiler versions run fine when I compile with egcs-2.90.25
        from linuxppc-R4!]


Either I am too dumb to build EGCS, or ... Has anybodyy else seen
strange problems with later versions of egcs?

Wolfgang

-- 
Phone:  (+49)-89-95720-110   Fax: (+49)-89-95720-112   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
C makes it easy for you to shoot yourself in the foot. C++ makes that
harder, but when you do, it blows away your whole leg.
                                                 -- Bjarne Stroustrup

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
