Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Dan Malek" <dan@embeddededge.com>
Subject: RE: 2.5 and request_8xxirq
Date: Wed, 15 Jan 2003 06:43:11 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFOEOGEAAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3E253735.8040300@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just use request_irq() instead....

> I'm in the process of porting my board based on a MPC850
> from 2.4 to 2.5 and it appears that request_8xxirq is gone.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
