Message-ID: <3B83D895.C5738613@mvista.com>
Date: Wed, 22 Aug 2001 12:06:45 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com> <20010822134155.4105@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> The function dereferences the regs of the init.task which no longer
> exist. (And was previously not properly initialized anyway).

Oh, now don't say that, it used to work :-).  At least for now,
don't enable KGDB.

> Probably. In my tree, I changed it to use the initcalls.

Will you please check that in?  I pused the files but couldn't
decide which method of initialization was "current" :-).

I'm still sorting out the bootloader stuff.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
