Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Hollis Blanchard" <hollis@austin.ibm.com>,
	"Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: PowerSpan PCI / sym2 SCSI
Date: Fri, 23 Aug 2002 08:08:53 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFEEBPDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1030114318.8559.28.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I didn't notice you were still having problems with version 1 of the
> driver; I thought you had resolved that. IME that almost always means
> your PCI config is not correct.

I have used a peek/poke utility to access the SYM53C8xx via PCI memory and
I/O. Both seem to be working fine. Obviously since the sym_2 driver works in
at least one configuration, the translation from the PCI bus back to CPU
memory is also correct. Still feels like an endian issue to me.

Thoughts?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
