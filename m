Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B741DDDE4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:26:31 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l49KN0Aq009905
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:23:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49KQMJa176050
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:26:22 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49KQMaD002981
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:26:22 -0600
Date: Wed, 9 May 2007 15:26:21 -0500
To: matthew@wil.cx
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20070509202621.GA4452@austin.ibm.com>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070420204720.GM31947@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Matthew,

I had been hoping these patches might make it into 2.6.22,
... this is a nag note; please forward upstream.

--linas

On Fri, Apr 20, 2007 at 03:47:20PM -0500, Linas Vepstas wrote:
> 
> Implement the so-called "first failure data capture" (FFDC) for the
> symbios PCI error recovery.  After a PCI error event is reported,
> the driver requests that MMIO be enabled. Once enabled, it 
> then reads and dumps assorted status registers, and concludes
> by requesting the usual reset sequence.
> 
> (includes a whitespace fix for bad indentation).
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
