Message-ID: <3F8AFD48.5070507@embeddededge.com>
Date: Mon, 13 Oct 2003 15:30:16 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steffen Rumler <Steffen.Rumler@siemens.com>
Cc: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 FCC enet driver problem
References: <000001c38766$68b14d90$5201a8c0@GEG2400> <3F86A52B.1070803@siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steffen Rumler wrote:


> I have not seen this kind of synchronization (PHY -- MAC) in fcc_enet.c.
> I don't know why.

The code is there.  You need a PHY interrupt to the processor when
the link status changes, then the PHY status is interrogated to set
up the MAC.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
