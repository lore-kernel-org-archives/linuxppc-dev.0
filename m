Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B711DE061
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 04:21:05 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
Date: Mon, 29 Jan 2007 10:20:12 -0700
In-Reply-To: <1170064058.19887.78.camel@concordia.ozlabs.ibm.com> (Michael
	Ellerman's message of "Mon, 29 Jan 2007 20:47:38 +1100")
Message-ID: <m1mz41lpgz.fsf@ebiederm.dsl.xmission.com>
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

> That was my suspicion as well, I was hoping someone who knew the code
> better than me would pipe up and let me know why it was a special case.
> Have the original MSI authors vanished without a trace?

I have never gotten any useable feedback from that direction anyway.

> It seems to date from the initial MSI submission, and has only ever been
> called from pci_free_resources(). The rest of the pci hotunplug code
> paths are not clear to me though, so I don't know whether we can rely on
> pci_disable_msi() already being called for us.

Good question.  I do know I have always been a little suspicions of
the suspend/resume path, because I haven't read them.

There may be a point in the hot-unplug where the code actually makes
sense in the don't touch the hardware kind of way.

Eric
