Message-ID: <39CC4642.4291D6A1@wanadoo.fr>
Date: Sat, 23 Sep 2000 07:57:22 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re; 2.4.0-test9 on B&W G3
References: <20000922164705.32547@mail.mipsys.com> <39CBAA3C.2CC16A34@wanadoo.fr> <39CC3D55.74CD42A2@wanadoo.fr> <20000922223145.B9334@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> On Sat, Sep 23, 2000 at 07:19:17AM +0200, Martin Costabel wrote:
>
> > But it doesn't recognize my SCSI disk. I think it's a feature of
> > -test9-pre4 that SCSI is broken. This is patched in pre5 or pre6. So
> > I'll wait or use Paul's drivers/scsi directory...
>
> Yes, test9 is the "Lets play with VM and SCSI" release.  Tho every one has
> booted on my x86 SCSI box (bk was up to pre5, or so jack howarth figured, either
> way going up to 6 shouldn't be too hard..)

I tried it with Paul's drivers/scsi, and it works now. The bk tree
didn't have the mesh.c update from pre5. Paul has Linus' ear, or so it
seems.

BTW, now that even the MOL patches have sneaked into Linus' tree, has
anyone got MOL to work on a 603 with the 2.4.0 kernel? Or what is
missing?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
