Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF54FDDFC4
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 09:03:58 +1100 (EST)
Date: Mon, 29 Jan 2007 15:03:46 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
Message-ID: <20070129220346.GA6630@colo.lackof.org>
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
	<20070129165217.GA10992@colo.lackof.org>
	<adabqkh22jy.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adabqkh22jy.fsf@cisco.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
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

On Mon, Jan 29, 2007 at 08:57:53AM -0800, Roland Dreier wrote:
>  > laptops now come with 1000BT chips that _do_ support MSI-X.
> 
> Really?  Which gigE chips are using MSI-X (as opposed to MSI)?

Sorry, I was thinking MSI (not MSI-X).
The point was that MSI will need suspend/resume support.

> (I am using MSI with e1000 on my laptop, but I've not seen any NICs
> other than 10-gigE NICs that even have an MSI-X capability -- none of
> the e1000, tg3 or bnx2 devices I have around have it at least)

yes - same here.  gige NICs don't need MSI-X if they can use MSI.

thanks,
grant
 
>  - R.
