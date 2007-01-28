Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89C4EDDFCA
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 07:48:09 +1100 (EST)
Message-ID: <45BD0BDC.40205@garzik.org>
Date: Sun, 28 Jan 2007 15:47:24 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] MSI portability cleanups
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<1170015805.26655.15.camel@localhost.localdomain>
In-Reply-To: <1170015805.26655.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tony Luck <tony.luck@intel.com>, Grant Grundler <grundler@parisc-linux.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, Ingo Molnar <mingo@elte.hu>,
	linux-pci@atrey.karlin.mff.cuni.cz, Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> The only architecture problem that isn't solvable in this context is
>> the problem of supporting the crazy hypervisor on the ppc RTAS, which
>> asks us to drive the hardware but does not give us access to the
>> hardware registers.
> 
> So you are saying that we should use your model while admitting that it
> can't solve our problems...
> 
> I really don't understand why you seem so totally opposed to Michael's
> approach which definitely looks to me like the sane thing to do. Note
> that in the end, Michael's approach isn't -that- different from yours,
> just a bit more abstracted.


I think the high-level ops approach makes more sense.  It's more future 
proof, in addition to covering all existing implementations.

	Jeff
