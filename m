Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A31EEDDEE0
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 06:34:47 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
References: <20080728023732.090aff83.sfr@canb.auug.org.au>
	<20080727182709.1dac0556@lxorguk.ukuu.org.uk>
	<20080727.125604.73857337.davem@davemloft.net>
Date: Sun, 27 Jul 2008 13:33:49 -0700
In-Reply-To: <20080727.125604.73857337.davem@davemloft.net> (David Miller's
	message of "Sun, 27 Jul 2008 12:56:04 -0700 (PDT)")
Message-ID: <adamyk35aoi.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > IMHO, this driver was really rushed in and that was a huge mistake.
 > If it had gone through linux-next we could have tidied all of this
 > stuff up in a less "rushed" manner.

??  This thread *is* about a build failure in linux-next.

 - R.
