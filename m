Date: Tue, 26 Sep 2000 20:46:06 +0200
From: Olaf Hering <olh@suse.de>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: R Shapiro <rshapiro@bbn.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Message-ID: <20000926204606.B467@suse.de>
References: <Pine.LNX.4.10.10009261825540.373-100000@cassiopeia.home> <Pine.LNX.4.10.10009262028450.20839-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009262028450.20839-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Tue, Sep 26, 2000 at 08:35:23PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 26, Michael Schmitz wrote:

> I've posted such a patch to debian-powerpc when one user there had this
> problem. That was before I learned booting with yaboot avoids the problem.
> If the resource conflict also happens on oldworld machines, I'd still
> prefer some suggestions to foolproof the patch (as in: how can I figure
> out if a region has been allocated by another card? What bits from the
> config registers should I look at?).

I have a precompiled benh Kernel at penguinppc.org/~olaf with Benhs current
kerneltree, your patch is still needed - otherwise *kaboom*


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
