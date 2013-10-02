Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD8E62C009D
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 07:58:53 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 3 Oct 2013 07:58:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C27012CE8052
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 07:58:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r92Lfe7O64356486
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 07:41:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r92LwbH9027326
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 07:58:38 +1000
Message-ID: <1380751112.645.64.camel@pasglop>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 03 Oct 2013 07:58:32 +1000
In-Reply-To: <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com> <1380620338.645.22.camel@pasglop>
 <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
 <524BDD73.3020106@redhat.com> <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-02 at 11:11 +0200, Alexander Graf wrote:

> Right, and the difference for the patch in question is really whether
> we handle in in kernel virtual mode or in QEMU, so the bulk of the
> overhead (kicking threads out of  guest context, switching MMU
> context, etc) happens either way.
> 
> So the additional overhead when handling it in QEMU here really boils
> down to the user space roundtrip (plus another random number read
> roundtrip).

Hrm, Michael had a real mode version ... not sure where it went then.

Cheers,
Ben.
