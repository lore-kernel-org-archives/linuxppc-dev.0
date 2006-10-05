Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F05EF67DE4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 08:10:34 +1000 (EST)
Subject: Re: [PATCH] powerpc: make U4 PCIe work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20061005170458.GL24705@localdomain>
References: <1160024098.22232.13.camel@localhost.localdomain>
	<20061005170458.GL24705@localdomain>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 08:10:26 +1000
Message-Id: <1160086226.22232.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Do the changes to fixup_maple_ide have anything to do with the rest of
> the patch?  It's not clear from your description.  And with that last
> hunk the function now appears to do nothing.

Hrm... I could split that indeed. The last bits to fixup_maple_ide()
should no longer be necessary. They used to work around broken PIBS but
that should have been fixed a long time ago.

> Could we consider merging the powermac and maple pci code into a
> common location that would be used by both platforms?  There's quite a
> bit of code duplication going on here...

A bit but not exactly... I may do it but just not right now.

Ben.
