From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16045.52678.862078.705908@argo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2003 10:56:38 +1000
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BK Id header removals causes patch to fail!
In-Reply-To: <001301c30dd8$f5f691e0$020120b0@jockeXP>
References: <IGEFJKJNHJDCBKALBJLLMEFBFMAA.joakim.tjernlund@lumentis.se>
	<IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se>
	<16045.43640.243207.193539@nanango.paulus.ozlabs.org>
	<001301c30dd8$f5f691e0$020120b0@jockeXP>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> hmm, the tree I am patching is a CVS tree. I can't get these in %F%
> form with CVS.

True.  Well, the best I can suggest is to write a script that runs sed
on all the files to change the BK Id lines back to the %F% form.

This sort of problem in patching is the primary reason why I removed
the BK Id lines.  They caused far more patch rejects than they were
worth (particularly now that Marcelo uses BK).

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
