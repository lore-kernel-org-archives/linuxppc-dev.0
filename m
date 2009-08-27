Return-Path: <alan@linux.intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 95C4FB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 19:23:45 +1000 (EST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 0E32EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 19:23:44 +1000 (EST)
Date: Thu, 27 Aug 2009 10:08:09 +0100
From: Alan Cox <alan@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Extending virtio_console to support multiple ports
Message-ID: <20090827100809.5f0aa0a7@linux.intel.com>
In-Reply-To: <1251346023.20467.21.camel@pasglop>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
	brueckner@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>,
	virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  - Then, are we certain that there's no case where the tty layer will
> call us with some lock held or in an atomic context ? To be honest,
> I've totally lost track of the locking rules in tty land lately so it
> might well be ok, but something to verify.

Some of the less well behaved line disciplines do this and always have
done.

Alan
 
