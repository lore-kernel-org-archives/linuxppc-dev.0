Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 25BC1B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 11:34:58 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7U1XkGx017506
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 11:33:46 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7U1XKc11450072
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 11:33:20 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7U1Yhov029778
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 11:34:44 +1000
Date: Tue, 30 Aug 2011 11:29:48 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Aaron Fabbri <aafabbri@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110830012948.GD4254@yookeroo.fritz.box>
References: <20110826193559.GD13060@sequoia.sous-sol.org>
	<CA7D4D51.FD84%aafabbri@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA7D4D51.FD84%aafabbri@cisco.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
	Chris Wright <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>, "Roedel,
	Joerg" <joerg.roedel@amd.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eOn Fri, Aug 26, 2011 at 01:17:05PM -0700, Aaron Fabbri wrote:
[snip]
> Yes.  In essence, I'd rather not have to run any other admin processes.
> Doing things programmatically, on the fly, from each process, is the
> cleanest model right now.

The "persistent group" model doesn't necessarily prevent that.
There's no reason your program can't use the administrative interface
as well as the "use" interface, and I don't see that making the admin
interface separate and persistent makes this any harder.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
