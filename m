Date: Fri, 24 Sep 1999 13:57:10 -0400 (EDT)
From: Anirudh Joshi <ajoshi@Glue.umd.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SndConfig for Linux/PPC
In-Reply-To: <99092411060800.00471@lintop>
Message-ID: <Pine.GSO.4.10.9909241353170.4557-100000@digital.eng.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	heh... funny you bring this up, cause just yesterday i decided
(was coaxed rather) to rewrite the awacs driver.  hopefully when i'm
finished, it'll be out of dmasound.c and awacs.c will be done The Right
Way (or whatever way i think is Right :).  anyhow, it'll have all the
goodies like mixer support, etc...


ani

On Fri, 24 Sep 1999, Jeramy B Smith wrote:

> 
> I've been thinking about making sndconfig run on linuxppc. 
> A. rip out the sun/sbus code
> B. remove defs for isa cards
> C. remove the defs for pci cards that don't work on linuxppc
> D. add dma sound def
> E. debug, debug, debug
> 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
