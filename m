Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 10CA9DE02C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:57:59 +1100 (EST)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
	<20070129165217.GA10992@colo.lackof.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 29 Jan 2007 08:57:53 -0800
In-Reply-To: <20070129165217.GA10992@colo.lackof.org> (Grant Grundler's
	message of "Mon, 29 Jan 2007 09:52:17 -0700")
Message-ID: <adabqkh22jy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > laptops now come with 1000BT chips that _do_ support MSI-X.

Really?  Which gigE chips are using MSI-X (as opposed to MSI)?

(I am using MSI with e1000 on my laptop, but I've not seen any NICs
other than 10-gigE NICs that even have an MSI-X capability -- none of
the e1000, tg3 or bnx2 devices I have around have it at least)

 - R.
