Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5924ADDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:10:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9IJBWR6006970
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 15:11:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9IJA0n0070264
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 15:10:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9IJ9oee023793
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 15:09:50 -0400
Date: Thu, 18 Oct 2007 14:09:39 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-ID: <20071018190939.GE29903@austin.ibm.com>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
	<1192670843.6681.10.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192670843.6681.10.camel@concordia>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 11:27:23AM +1000, Michael Ellerman wrote:
> 
> It does what pci_device_to_OF_node() does, but in the right way. 
> 
> The plan is to remove pci_device_to_OF_node() once all the callers have
> been converted to properly handle the refcounting. 

Oh. Yes. well, of course, then. Excellent reason. I didn't get 
that from the patch commit comments. So, FWIW:

Ack'ed-by: Linas Vepstas <linas@austin.ibm.com>

--linas
