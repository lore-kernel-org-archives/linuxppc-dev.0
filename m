From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15308.58189.136492.881833@cargo.ozlabs.ibm.com>
Date: Wed, 17 Oct 2001 11:47:56 +1000 (EST)
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pci_dma_sync_single
In-Reply-To: <3BCC324C.9EE9C105@raleigh.ibm.com>
References: <15308.8725.416230.867981@cargo.ozlabs.ibm.com>
	<3BCC324C.9EE9C105@raleigh.ibm.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach writes:

> This would probably work, except on Book E platforms, where DR off
> simpley gets you another translaton and NOT
> a physical address.

We don't support any Book E platforms at the moment anyway.  When we
do this will be one of the issues we have to address.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
