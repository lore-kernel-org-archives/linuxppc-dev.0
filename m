Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Hollis Blanchard" <hollis@austin.ibm.com>,
	"Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: PowerSpan PCI / sym2 SCSI
Date: Fri, 23 Aug 2002 07:35:19 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEBODLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1030112414.8559.20.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > However it only works if you select the "normal I/O" option with the
> > SYM53C8xx version 2 driver. SYM53C8xx version 1 does not work. Version 2
> > does not work if the I/O option is not selected.
>
> It might help if you described "does not work" in more detail... could
> you paste error messages?

http://lists.linuxppc.org/linuxppc-dev/200208/msg00032.html
More information here than would need...

> I've seen a problem on PReP where although the SCSI card is addressed at
> 0xc0000000, the BAR is 0x0 (because of the host bridge offset). From
> memory, the sym2 driver checks the BAR and if it's 0 errors out.
> Removing that check or enabling "normal IO" worked fine. Of course, this
> might not be your problem, but without actual error messages...

This sounds promising. Is this check in both versions of the driver? I don't
remember a BAR check. I thought it just ioremapped() the region. Could you
provide a reference? (line#)

THX


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
