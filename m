Message-Id: <200109211735.NAA28438@makai.watson.ibm.com>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-dev@lists.linuxppc.org,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Mark Salisbury <mbs@mc.com>,
	"Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers) 
In-Reply-To: Message from Ralph Blach <rcblach@raleigh.ibm.com>
   of "Fri, 21 Sep 2001 13:01:49 EDT." <3BAB727D.C85E5CB@raleigh.ibm.com>
Date: Fri, 21 Sep 2001 13:35:29 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Ralph Blach writes:

Ralph> I know the discussions on Book E are incorrect.  I have had the
Ralph> privilege here in
Ralph> IBM to work on the 440gp processor.  Although my knowledge of powerpc is
Ralph> far from complete, I can tell everybody that from my experience that the
Ralph> Book E architecture is superior.

Ralph> I believe that Book E processor which have been announced by both
Ralph> Motorola and IBM
Ralph> will be VERY successful.

Ralph> I am personally excited by the future of book E.  The Engineers here
Ralph> working on delivering it are simply the best with whom I have every
Ralph> worked.  ( I have been at IBM for over 20 years).

	I wish that you had not made these statements because you now
force others from IBM to disagree with you in public or let people assume
your opinion uniformly represents IBM.  This isn't a question of the
quality of the implementation by engineers, it is a question of the design
itself.  Making categorical statements that "you know" something is very
dangerous.

	PowerPC Book E effectively is a different architecture.  The User
Instruction Set Architecture (UISA) changes address perceived problems
which never really existed.  It is a fine architecture for its purpose,
but it complicates the ability to share user code and tools with the rest
of the PowerPC world and undermines the unifying opportunity for the
PowerPC architecture scaling across a wide range of uses.

	Your comments of praise focus completely on Supervisor mode
changes.  If the designers of the Book E architecture had left the Book I
UISA alone for compatibility with the original PowerPC archiecture, I
believe that everyone would be a lot happier and more uniformly
supportive.  There is a lot more agreement that the Supervisor mode
changes are useful for the embedded market -- the target of "Book E".  I
wish that the PowerPC Book E architecture designers had limited themselves
to modifications which were not visible to user programs.

	Change comes with a cost; compatibility is important too.

David

	P.S. The above comments are my own opinion and are not intended to
imply that they represent any company or organization.  The same applies
to Ralph's comments which should have included an equivalent disclaimer.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
