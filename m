Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CA70DE008
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:36:28 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 6/16] Add bare metal MSI enable & disable routines
References: <20070125083412.077F8DE320@ozlabs.org>
Date: Thu, 25 Jan 2007 22:35:37 -0700
In-Reply-To: <20070125083412.077F8DE320@ozlabs.org> (Michael Ellerman's
	message of "Thu, 25 Jan 2007 19:34:10 +1100")
Message-ID: <m11wlixsd2.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> Add bare metal MSI enable & disable routines.

What is the plan for MSI-X support.  That is the interesting case in hardware.
hardware to support.

Eric
