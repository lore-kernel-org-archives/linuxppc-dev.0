Message-Id: <200108171724.NAA23832@makai.watson.ibm.com>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: program counter.. 
In-Reply-To: Message from Raghava Raju <vraghava_raju@yahoo.com>
   of "Fri, 17 Aug 2001 10:13:44 PDT." <20010817171344.83793.qmail@web20004.mail.yahoo.com>
Date: Fri, 17 Aug 2001 13:24:29 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Raghava Raju writes:

Raghava> I was unable to find the registers for
Raghava> program counter,stack pointer. Which registers
Raghava> I should use to access these values in powerpc.

	The PowerPC ABI's specify that the stack pointer is in r1.  The
PowerPC architecture does not have a program counter in user-accessible
register.  One can obtain the PC of the last call (branch and link) from
the link register.  One can branch and link to the next instruction to
obtain the current PC, but make sure that the old value in the LR is saved
and restored as required by the ABI.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
