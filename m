Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E14167C25
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 21:29:33 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
References: <1162884080.585336.70559261997.qpush@cradle>
	<1162885276.28571.444.camel@localhost.localdomain>
	<20061107080257.GA5874@kroah.com>
	<1162963101.20271.18.camel@localhost.localdomain>
Date: Wed, 08 Nov 2006 03:26:47 -0700
In-Reply-To: <1162963101.20271.18.camel@localhost.localdomain> (Michael
	Ellerman's message of "Wed, 08 Nov 2006 16:18:21 +1100")
Message-ID: <m1fycu5j4o.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

>> Oh, and I think your first two patches can be applied now to the tree
>> (header file changes).  Any objection to me doing this?
>
> There's a trivial bug in 1/7 (HT #defines), so hold back on that one
> until I resend. The movement of MSI-X #defines is good to go. I also
> sent you the patch to add HT_SUBCAP_OFFSET yesterday that I think is
> ready to merge.

Actually now that I am thinking about it I'm not at all certain about
the HT_SUBCAP_OFFSET patch.  The basic issue is that it suggests that
the field that specifies which type of hypertransport capability has a
fixed number of bits.  While in reality the encoding is variable
length.

Eric
