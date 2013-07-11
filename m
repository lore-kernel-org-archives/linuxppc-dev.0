Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B05202C03CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:56:44 +1000 (EST)
Message-ID: <1373547392.19894.100.camel@pasglop>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 11 Jul 2013 22:56:32 +1000
In-Reply-To: <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>
 <51DC4923.5010501@suse.de> <51DE7377.1060503@ozlabs.ru>
 <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
 <1373546233.19894.85.camel@pasglop>
 <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 14:50 +0200, Alexander Graf wrote:
> > Not really no. But that would do. You could have give a more useful
> > answer in the first place though rather than stringing him along.
> 
> Sorry, I figured it was obvious.

It wasn't no, because of the mess with modules and the nasty Makefile we
have in there. Even I had to scratch my head for a bit :-)

Ben.
