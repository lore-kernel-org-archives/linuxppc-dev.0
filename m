Message-Id: <200101202137.QAA22694@mal-ach.watson.ibm.com>
To: khendricks@ivey.uwo.ca
cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Issue with small struct return values 
In-Reply-To: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
   of "Sat, 20 Jan 2001 09:43:02 EST." <01012009430200.23836@localhost>
Date: Sat, 20 Jan 2001 16:37:33 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Kevin B Hendricks" writes:

Kevin> Did anyone actually get back to you on this issue?

	Geoff and I discussed the issue with Andy previously and we
suggested that he post a message to these lists.

Kevin> I think people knew about this inconsistency but did not push matters.
Kevin> AFAIK, the gcc toolchain for ppc has always ignored that part of the abi.

	IBM wants GCC (and therefore PowerPC Linux) to follow the SVR4 ABI
as written.  GCC should not be inventing new ABIs when perfectly good and
correct ABIs exist.  The longer this is allowed to continue, the harder it
is to correct.

	GCC 3.0 (whose major number implies breaking backward
compatibility) seems like a good opportunity to correct this mistake.

Kevin> For what it is worth, I have found out that the abis implemented by PPC BSD,
Kevin> MacOSX, IBM, and PPC Linux all differ in strange ways (even Mac OSX ABI is
Kevin> not identical to IBM's EABI on which it was based).  So in the long run, I am
Kevin> not sure that this issue matters.

	Neither IBM (AIX PowerOpen ABI?) nor MacOSX are based on the eABI.
Yes, they differ, but that is because they are different ABIs.  The Mac
PowerPC ABI is based on the IBM PowerOpen ABI.

	This issue does matter because this mistake harms PowerPC
performance on these systems, and because other commercial compilers
implement the ABI correctly which causes this GCC mistake to interfere
with interoperability.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
