Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: very minor 405GP and 405GPr PCI difference
Date: Tue, 1 Oct 2002 21:26:18 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20021002014219.GF1848@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> That's right.  Is there a reason for boards to have different
> mappings?  I can well believe that there is, but the current tree
> doesn't show it - all the boards (in the tree) that have PCI appear to
> do the same initialisation of the windows.  It doesn't seem worthwhile
> to create board specific PCI initialisation hooks until we have a
> board that needs it.

If all boards are suppose to have the same mapping, why doesn't someone
document it as such? It would have saved me a lot of time. If it isn't a
good enough rule to be documented then make the system flexible enough to
take a different path if required. (proactive)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
