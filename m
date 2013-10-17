Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id BA4392C0127
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 03:50:08 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH -V2 06/14] kvm: powerpc: booke: Convert BOOKE to use
 kvmppc_ops callbacks
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1381164482-31001-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 17 Oct 2013 18:50:02 +0200
Message-Id: <01BC643C-0AA9-47E8-A7E9-7A84AB280298@suse.de>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1381164482-31001-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Make required changes to get BOOKE configs to build with
> the introduction of kvmppc_ops callback
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This can not be a separate commit, as you're breaking bisectability for =
booke this way.

I've squashed this in with the previous commit.


Alex
