Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34D3CDDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 07:22:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l39LMhjg026562
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 17:22:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l39LMhpi287668
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 17:22:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l39LMh9j017164
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 17:22:43 -0400
Date: Mon, 9 Apr 2007 16:22:43 -0500
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
Message-ID: <20070409212242.GE4747@austin.ibm.com>
References: <11758956393793-patch-mail.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11758956393793-patch-mail.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, thlin@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2007 at 04:40:40PM -0500, Brian King wrote:
> 
> Adds the pSeries platform implementation for a new PCI API
> which can be used to issue various types of PCI-E reset,
> including PCI-E warm reset and PCI-E hot reset. This is needed
> for an ipr PCI-E adapter which does not properly implement BIST.
> Running BIST on this adapter results in PCI-E errors. The only
> reliable reset mechanism that exists on this hardware is PCI
> Fundamental reset (warm reset). 
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Linas Vepstas <linas@austin.ibm.com>
