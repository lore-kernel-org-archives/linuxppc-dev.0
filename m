From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15625.11479.788090.432664@argo.ozlabs.ibm.com>
Date: Fri, 14 Jun 2002 09:37:59 +1000 (EST)
To: Eugene Surovegin <ebs@innocent.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
In-Reply-To: <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
	<20020613205824.GX13541@opus.bloom.county>
	<5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If we are going to be calling get_vm_area from interrupt context we
need to change the write_lock/write_unlock calls to write_lock_irqsave
and write_unlock_irqrestore.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
