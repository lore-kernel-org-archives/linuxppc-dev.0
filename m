Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F227ADE01A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:52:35 +1100 (EST)
Date: Mon, 29 Jan 2007 09:52:17 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
Message-ID: <20070129165217.GA10992@colo.lackof.org>
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>, Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 08:47:38PM +1100, Michael Ellerman wrote:
...
> > The mthca IB driver was one of the early adopters of MSI, and it uses
> > MSI-X.  So it isn't that no one is using MSI-X and the MSI-X code
> > paths don't get exercised.
> 
> I meant the MSI-X suspend/resume path specifically, I'm guessing most
> laptops don't come with IB cards yet ;)

laptops now come with 1000BT chips that _do_ support MSI-X.

grant
