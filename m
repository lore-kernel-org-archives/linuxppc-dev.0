Return-Path: <srs0=lxei=bc=redhat.com=rkrcmar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y63zy30j5zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 03:15:58 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y63zx60fwz8t5X
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 03:15:57 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y63zw6jYrz9t2x
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2017 03:15:55 +1100 (AEDT)
Date: Tue, 3 Oct 2017 18:15:49 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: Fix server always zero from
 kvmppc_xive_get_xive()
Message-ID: <20171003161548.GA16800@flask>
Reply-To: 20171002065745.GA2755@umbus.fritz.box
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2017-10-02, David Gibson:
> Paolo,
> 
> Here's BenH's ack.  Again, this is a pretty important fix for us, and
> Paulus is away.  Can you take this into the KVM tree please.

Applied to kvm/master, thanks.

(Turns out I'm not on any cc'd list, so the author date might be off.)
