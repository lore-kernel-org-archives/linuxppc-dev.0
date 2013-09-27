Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 520ED2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 21:43:33 +1000 (EST)
Subject: Re: [RFC PATCH 04/11] kvm: powerpc: book3s: Add a new config variable
 CONFIG_KVM_BOOK3S_HV
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380276233-17095-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 13:43:29 +0200
Message-Id: <F47EA67A-B8C0-409F-A4D4-3BA7D11E01F5@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This help ups to select the relevant code in the kernel code
> when we later move HV and PR bits as seperate modules.

I don't think I grasp what semantically the difference between =
CONFIG_KVM_BOOK3S_HV and CONFIG_KVM_BOOK3S_64_HV is :).


Alex
