Date: Thu, 7 Feb 2002 20:02:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020208030227.GA15584@opus.bloom.county>
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr> <20020207144308.C19569@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020207144308.C19569@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 07, 2002 at 02:43:08PM -0700, Val Henson wrote:
>
> On Tue, Feb 05, 2002 at 08:33:16PM +0100, Benjamin Herrenschmidt wrote:
> >
> > And let me know if you find something ;)
>
> I pulled the latest linuxppc_2_4_devel, ported gemini to it, and ran
> an overnight test with:
>
> NFS mounted root filesystem
> while (true) do make clean; make -j8 zImage; done
> crashme +2000 666 100 8:00:00 2
> Flood ping in and out
>
> On a dual 7410 Gemini with 1 GB RAM.  Used all but 70MB of memory.  No
> hangs.
>
> The weird thing is that crashme was supposed to run for 8 hours but
> it's been running for over 14 hours now.  Any ideas?

Hmm.  Have you tried timing some 'simple' things and seeing if thats
correct?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
