Message-Id: <200001220016.TAA19532@mal-ach.watson.ibm.com>
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: Message from Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
   of "Fri, 21 Jan 2000 17:53:50 EST." <Pine.SOL.3.96.1000121174930.10776A-100000@bacon.math.uwaterloo.ca>
Date: Fri, 21 Jan 2000 19:16:43 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Others probably can answer configuring GCC for Linux/PPC better
than I, but it is looking for something like "powerpc-unknown-linux-gnu"
as the target.

	rs6000 is NOT another ppc based architecture.

	If you are trying to build a linuxppc compiler hosted on x86
Linux, then you need to build a cross-compiler.  Please read the cross-gcc
FAQ to learn how to do this:

http://www.objsw.com/CrossGCC/

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
