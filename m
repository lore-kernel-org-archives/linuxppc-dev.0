Message-ID: <39A40BE3.11A6D4E1@embeddededge.com>
Date: Wed, 23 Aug 2000 13:37:39 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Ronald Wahl <rwa@peppercon.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.LNX.4.21.0008231540530.12497-100000@goliath.issistance.de> <20000823140327.30773@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> ... Most PPC machines out there (all PCI PPC machines) are,
> AFAIK, cache coherents. PPC NuBus powermacs are not.


The MPC8xx and IBM 4xx systems can have PCI options but are not
cache coherent.  PCI masters are still challenging (if you can actually
get them to work :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
