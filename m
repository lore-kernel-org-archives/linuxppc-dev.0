Message-Id: <200109211858.OAA22552@makai.watson.ibm.com>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-dev@lists.linuxppc.org,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Mark Salisbury <mbs@mc.com>,
	"Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers) 
In-Reply-To: Message from Ralph Blach <rcblach@raleigh.ibm.com>
   of "Fri, 21 Sep 2001 13:01:49 EDT." <3BAB727D.C85E5CB@raleigh.ibm.com>
Date: Fri, 21 Sep 2001 14:58:23 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Ralph Blach writes:

Ralph> Although my knowledge of powerpc is
Ralph> far from complete, I can tell everybody that from my experience that the
Ralph> Book E architecture is superior.

Ralph> I believe that Book E processor which have been announced by both
Ralph> Motorola and IBM will be VERY successful.

	Let me clarify a point in my previous reply: the PowerPC Book E
changes to the PowerPC Book I UISA affect 64-bit PowerPC only.  The 32-bit
subset of PowerPC Book E is compatible with the rest of the PowerPC
architecture family.  IBM's PowerPC 440GP implements the 32-bit PowerPC
Book E architecture.

	As I said in my original message, the supervisor and non-UISA
changes are very useful and have a lot of support from the embedded
PowerPC developer community.  The IBM PowerPC 440GP and other 32-bit
PowerPC Book E chips implement the areas of agreement and compatibility
which create broad support for the PPC 440GP chip and the PowerPC
architecture.  I am happy when the various chip implementations in the
PowerPC architecture family complement and reinforce each other.

David

	P.S. The above comments are my own opinion and are not intended to
imply that they represent any company or organization.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
