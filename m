Date: Thu, 11 Apr 2002 10:03:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: The very common kernel, again... (Was: Re: CONFIG_GENERIC_PPC32)
Message-ID: <20020411170356.GB19157@opus.bloom.county>
References: <20020411152458.GB15663@opus.bloom.county> <0204111616.AA28753@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204111616.AA28753@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 09:16:08AM -0700, Michael Sokolov wrote:

> I want my boards
> supported in the CONFIG_ALL_PPC kernel or its successor and I'm prepared
> to do whatever boot mechanism changes it takes to do that.

Why?  Why is it a good thing to put this into 'CONFIG_ALL_PPC' ?  You
still end up with 3 images (PReP, vmlinux for pmac/chrp, PPCStar) which
I wouldn't think is any worse from N (either the FW lets you load an
abitrary kernel off of the CD/HD/whatever, or you have to put on the
!vmlinux (in CONFIG_ALL_PPC's case, yaboot) booting kernel else-where.

This pops up now and again, and I still don't quite see why.  What I can
see as a good idea is something like CONFIG_HEC (in your case) which
since the FW is known and it is possible to figure out the model you're
on, have one kernel that runs on the whole product line.  This, iirc, is
what the current gemini bits do (Val, if you do happen to be reading
this, would CONFIG_SYNERGY make more sense than CONFIG_GEMINI at this
point?  Just curious...) and what the pmac (and to an extent chrp and
prep as well) do.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
