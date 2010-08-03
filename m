Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206]) by ozlabs.org (Postfix) with ESMTP id DD240B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Aug 2010 02:31:36 +1000 (EST)
Received: from mail50-am1 (localhost.localdomain [127.0.0.1])	by
	mail50-am1-R.bigfish.com (Postfix) with ESMTP id DD654D90253	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  3 Aug 2010 16:16:17 +0000 (UTC)
Received: from am1ehsmhs001.bigfish.com (unknown [10.3.201.242])	by
	mail50-am1.bigfish.com (Postfix) with ESMTP id 80F84E70051	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  3 Aug 2010 16:16:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o73GGDmE017918	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 3 Aug 2010 09:16:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o73GRVLi013792	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 3 Aug 2010 11:27:31 -0500 (CDT)
Date: Tue, 3 Aug 2010 11:16:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
Message-ID: <20100803111611.38ca87e6@schlenkerla.am.freescale.net>
In-Reply-To: <C27A7E71-2F93-45D2-989D-0AB80D9C2C0B@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
	<4C557E7A.3010606@redhat.com>
	<C27A7E71-2F93-45D2-989D-0AB80D9C2C0B@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avi Kivity <avi@redhat.com>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 1 Aug 2010 22:21:37 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 01.08.2010, at 16:02, Avi Kivity wrote:
> 
> > Looks reasonable.  Since it's fair to say I understand nothing about powerpc, I'd like someone who does to review it and ack, please, with an emphasis on the interfaces.
> 
> Sounds good. Preferably someone with access to the ePAPR spec :).

The ePAPR-relevant stuff in patches 7, 16, and 17 looks reasonable.
Did I miss any ePAPR-relevant stuff in the other patches?

-Scott
