Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17480.48944.451869.575596@cargo.ozlabs.ibm.com>
Date: Fri, 21 Apr 2006 21:17:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
In-Reply-To: <644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<1143564910.2660.4.camel@enki.eridu>
	<644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming writes:

> So no one chimed in on this.  Clearly, 1275 states that it's supposed  
> to be local-mac-address or mac-address.  We use "address".  But I'm  
> pretty sure we copied our ethernet node from somewhere else, so which  
> one should it be?

It shouldn't be "address".  That would normally be the physical
address of the device's registers, if anything.

Paul.
