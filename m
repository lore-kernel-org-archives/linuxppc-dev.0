From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15718.52527.24904.317204@argo.ozlabs.ibm.com>
Date: Sat, 24 Aug 2002 10:02:55 +1000 (EST)
To: <acurtis@onz.com>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 Memory Management
In-Reply-To: <NCBBIINEHIPFGJPLBEIFAEBNDLAA.acurtis@onz.com>
References: <3D65C19C.2070503@embeddededge.com>
	<NCBBIINEHIPFGJPLBEIFAEBNDLAA.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis writes:

> Basically, remove all the CONFIG_8260 conditional compile stuff.

I just looked in arch/ppc in the linuxppc_2_4_devel tree and there are
only 3 places where CONFIG_8260 is used in the code.  Two of them are
for the cheesy request_8xxirq thing.  The other is for m8260_gorom.
So I'm not sure what you're referring to.

Dan, can we *please* take out the #define request_irq request_8xxirq
and just use request_irq like everyone else?

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
