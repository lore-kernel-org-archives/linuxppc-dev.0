Message-ID: <39C25A1D.58CA03F3@mvista.com>
Date: Fri, 15 Sep 2000 13:19:25 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "G. Guével" <gguevel@interfaceconcept.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU problems on MPC860P
References: <000101c01f33$a5f58ca0$2901a8c0@none>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


G. Guével wrote:

> I want to port this kernel on a MPC860P proprietary board called pLines.

There aren't any software changes to required to support the 860P.  I
have a couple for testing that I use regularly.

What is the silicon revision of the part?  I think they are all fairly
new, but this sounds like a CPU6 errata, which I didn't think affected
the 860P.

For all 860 processors that use FEC (855/860 T and P), make sure you
have the FEC driver that looks at the IMMR for the silicon revision and
sets the Port D bits correctly.  These changed at some point (I don't
remember exactly, either B to C or C to D).  This doesn't cause the
problem you see here, but it will keep the FEC from working properly.

You may just want to hop over to the MontaVista web site and use the
2.2.14 kernel from CDK 1.2.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
