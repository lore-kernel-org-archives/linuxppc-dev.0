Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7B77DDEF7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:20:27 +1100 (EST)
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20070111194427.GA20450@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 08:20:02 +1100
Message-Id: <1168550403.22458.414.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So, no, I don't agree with this implementation and don't want to see it
> go through anyone's tree into mainline just yet.

So why, when we posted it earlier, you said the exact opposite ? That
you actually liked it and wanted to see it as a replacement of the
current cruft ?

That's been the logic from day one. We implement a generic MSI support
that supports multiple backends, we do it as a powerpc version at first
since that's what we can actively test and provide backends for, then as
a second step, we work with the intel folks to port their stuff over to
our implementation and replace the current crappy generic one.

Ben.
