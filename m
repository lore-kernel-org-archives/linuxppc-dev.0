Message-Id: <200001230215.VAA21612@mal-ach.watson.ibm.com>
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: Message from Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
   of "Sat, 22 Jan 2000 01:45:00 EST." <Pine.SOL.3.96.1000122013827.17059B-100000@fitch.math.uwaterloo.ca>
Date: Sat, 22 Jan 2000 21:15:53 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Robert Neugebauer writes:

Robert> I am not trying to build a cross compiler, I am not trying to build GCC.
Robert> My course at university uses its own compiler called uC++ (Micro C++).

Robert> The compiler thus far only has the following targets that work:
...
Robert> dmake ibm-rs6000
...
Robert> By my knowledge rs6000 is a RISC based architecture, thus I tried to build
Robert> uC++ using the target ibm-rs6000. This resulted in an unrecognized opcode
Robert> movl during compilation.

Robert> If someone knows what the similar instruction on my G4 is, and any other
Robert> problems I might/will encounter, I would appreciate it.

	Neither the original POWER architecture (aka "rs6000"), nor the
PowerPC architecture contain a "movl" instruction and/or mnemonic.  You
said above that target ibm-rs6000 works, but I assume that you mean it is
a uC++ target you are attempting to use.  If uC++ is producing that
instruction for the "rs6000" architecture, then there is something
severely wrong with its ibm-rs6000 target that has nothing to do with
POWER versus PowerPC ("G4") architectures.

	If the ibm-rs6000 uC++ target is suppose to work, then it still
might be a problem of lingering x86 configuration files that were not
cleared when you tried to build the ibm-rs6000 target.

	Gabriel Paubert gave a good summary of the differences between the
related architectures and what would need to be changed in the ibm-rs6000
target of the uC++ compiler to generate correct PowerPC code.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
