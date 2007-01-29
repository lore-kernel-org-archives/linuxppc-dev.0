Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 95391DE09C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 04:33:00 +1100 (EST)
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
	<20070129165217.GA10992@colo.lackof.org> <adabqkh22jy.fsf@cisco.com>
	<ada7iv522cl.fsf@cisco.com> <m1ireplp86.fsf@ebiederm.dsl.xmission.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 29 Jan 2007 09:32:52 -0800
In-Reply-To: <m1ireplp86.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Mon, 29 Jan 2007 10:25:29 -0700")
Message-ID: <ada1wldzqkb.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > There is this function.  It does save the table, I haven't
 > looked closely enough yet to know if it saves all of the
 > other details yet.

OK, fair enough, I missed that call to pci_save_msix_state() in
pci_save_state().  Yeah, I guess it's close to working.

 - R.
