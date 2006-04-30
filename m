Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6156867B23
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 01:08:51 +1000 (EST)
Date: Sun, 30 Apr 2006 10:07:34 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: please pull powerpc.git 'merge' branch
Message-ID: <20060430150734.GT5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
	<20060430042059.GO5518@pb15.lixom.net>
	<200604301342.02043.arnd@arndb.de>
	<20060430150356.GR5518@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060430150356.GR5518@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 30, 2006 at 10:03:56AM -0500, Olof Johansson wrote:
> On Sun, Apr 30, 2006 at 01:42:01PM +0200, Arnd Bergmann wrote:
> 
> > The Cell Broadband Engine Architecture in theory is 2.03 and also mandates
> > some of the extensions that are optional in there.
> > The relevant sections in the specs are:
> 
> Ok. So Cell should really set PPC_FEATURE_ARCH_2_02 then, and possible
> PPC_FEATURE_CELL to signify the cell extensions?
> 
> Right now ARCH_2_02 is not set as far as I can see.

s/2_02/2_03/g


-Olof
