Date: Tue, 29 Apr 2003 11:11:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BK Id header removals causes patch to fail!
Message-ID: <20030429181105.GA15338@ip68-0-152-218.tc.ph.cox.net>
References: <IGEFJKJNHJDCBKALBJLLMEFBFMAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se> <16045.43640.243207.193539@nanango.paulus.ozlabs.org> <001301c30dd8$f5f691e0$020120b0@jockeXP> <16045.52678.862078.705908@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16045.52678.862078.705908@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 29, 2003 at 10:56:38AM +1000, Paul Mackerras wrote:
>
> Joakim Tjernlund writes:
>
> > hmm, the tree I am patching is a CVS tree. I can't get these in %F%
> > form with CVS.
>
> True.  Well, the best I can suggest is to write a script that runs sed
> on all the files to change the BK Id lines back to the %F% form.

BTW, I nuked the tags, both in BK and in a CVS tree, with the same bit
of sed'ing.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
