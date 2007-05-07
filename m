Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA3D3DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 03:04:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47H4L3r031653
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:04:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47H4LG4482988
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:04:21 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47H4KWV006849
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:04:21 -0400
Date: Mon, 7 May 2007 12:04:20 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 17/19] PCI: rpaphp: Use pcibios_remove_pci_devices()
	symmetrically
Message-ID: <20070507170418.GE4452@austin.ibm.com>
References: <20070403173154.77B623A65C@topology.austin.ibm.com>
	<1178514554.14398.26.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178514554.14398.26.camel@concordia.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	pcihpd-discuss@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 03:09:14PM +1000, Michael Ellerman wrote:
> > -
> > +	pcibios_remove_pci_devices(slot->bus);
> 
> You need to add an EXPORT_SYMBOL() for this.

Dohh!  I should know better by now, shouldn't I?

--linas
