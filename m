Message-Id: <200112052020.PAA22854@makai.watson.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1 
In-Reply-To: Message from Daniel Jacobowitz <dmj+@andrew.cmu.edu>
   of "Wed, 05 Dec 2001 15:17:21 EST." <20011205151721.A18191@nevyn.them.org>
Date: Wed, 05 Dec 2001 15:20:45 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Daniel Jacobowitz writes:

Daniel> Has either of you tried to boot a kernel in which RELOC is a function?
Daniel> If I'm following any of what's going on here, function symbols are
Daniel> global.  To call the function you would need to use RELOC.

	PowerPC branches are relative.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
