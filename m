Message-ID: <37EE3B3A.F40E0D62@netx4.com>
Date: Sun, 26 Sep 1999 11:26:50 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Anirudh Joshi <ajoshi@Glue.umd.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SndConfig for Linux/PPC
References: <Pine.GSO.4.10.9909241353170.4557-100000@digital.eng.umd.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anirudh Joshi wrote:

> 
>         heh... funny you bring this up, cause just yesterday i decided
> (was coaxed rather) to rewrite the awacs driver.  hopefully when i'm
> finished, it'll be out of dmasound.c and awacs.c will be done The Right
> Way (or whatever way i think is Right :).  anyhow, it'll have all the
> goodies like mixer support, etc...

What version are you looking at?  The current version works and
has mixer support.  The Rigth Way is always a personal opinion,
and rewriting something for the sake of changing variable names
or personal coding style is a waste of time.

If you decide you have time to waste on this, make sure you start
with the latest 2.3.x version, and ask me for all of the updates
I have queued to test and check in over the next couple of weeks.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
