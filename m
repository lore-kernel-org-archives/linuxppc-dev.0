Message-Id: <200001211908.OAA27094@mal-ach.watson.ibm.com>
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: Message from Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
   of "Fri, 21 Jan 2000 13:40:14 EST." <Pine.SOL.3.96.1000121133401.17001B-100000@bacon.math.uwaterloo.ca>
Date: Fri, 21 Jan 2000 14:08:52 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	"movl" is an x86 mnemonic.  "rs6000" is the same as "powerpc" as
far as GCC configurations are concerned, for the most part.  RISC
arcihtecture is a generic computer architecture term that does not provide
any assistance in compatibility.  Other than that, I cannot understand
what you are trying to accomplish.

	Are you trying to build a cross compiler?  From linuxppc to x86
linux?  From x86 linux to linuxppc?  From either of those to RS/6000 AIX?
It does not sound like you have the cross-toolchain properly configured
and/or you are not following the proper sequence to build a
cross-toolchain and/or you have some old configuration/build files laying
around when trying to build a new toolchain.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
