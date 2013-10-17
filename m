Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id BEFEC2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 03:50:05 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH -V2 00/14] Allow PR and HV KVM to coexist in one kernel
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 17 Oct 2013 18:49:58 +0200
Message-Id: <E15C9750-E648-47CD-990F-FE02DCE7E6BE@suse.de>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.10.2013, at 18:47, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Hi All,
>=20
> This patch series support enabling HV and PR KVM together in the same =
kernel. We
> extend machine property with new property "kvm_type". A value of "HV" =
will force HV
> KVM and "PR" PR KVM. If we don't specify kvm_type we will select the =
fastest KVM mode.
> ie, HV if that is supported otherwise PR.

Thanks, applied all to kvm-ppc-queue.


Alex
