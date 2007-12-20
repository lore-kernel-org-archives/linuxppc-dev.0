Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18281.59210.200603.12093@cargo.ozlabs.ibm.com>
Date: Thu, 20 Dec 2007 14:53:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
In-Reply-To: <20071204210344.GE8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204204432.GD8099@lixom.net> <4755BD7B.6030208@garzik.org>
	<20071204210344.GE8099@lixom.net>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> > FWIW I'm presuming this work will go via a powerpc tree not libata... 
> > Generally that's not the case, but here it's largely an arch-specific work.
> 
> Ok, that works. I was thinking of letting this patch go through libata,
> and do the removal through the powerpc merge path. But I can do both
> through powerpc.

Are you going to send me a patch to do this addition plus the removal
of the old stuff, or do you want me to merge this patch as is?

Paul.
