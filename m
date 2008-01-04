Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 50127DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 10:03:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCh v3] powerpc: add hugepagesz boot-time parameter
Date: Sat, 5 Jan 2008 00:03:13 +0100
References: <477D68E6.2070108@linux.vnet.ibm.com>
	<200801040034.25329.arnd@arndb.de>
	<477E9073.1050900@linux.vnet.ibm.com>
In-Reply-To: <477E9073.1050900@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801050003.15232.arnd@arndb.de>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Adam Litke <agl@linux.vnet.ibm.com>, mel@csn.ul.ie,
	David Gibson <dwg@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>, csnook@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 January 2008, Jon Tollefson wrote:
> Arnd Bergmann wrote:
> > We started discussing this in v1, but the discussion got sidetracked:
> > Is there a technical reason why you don't also allow 1M pages, which
> > may be useful in certain scenarios?
> > =A0=20
> No, it was mostly a matter of the time I have had and machines easily
> available to me for testing. =A0I don't know of a technical reason that
> would prevent supporting 1M huge pages, but would want the tests in the
> libhugetlbfs suite to pass, etc.

Ok. Do you think the kernel should be able to change the page size settings
in that case, or should we rely on whatever the firmware tells us it has
configured already?

	Arnd <><
