Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0AAB2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 21:29:58 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] powerpc: book3s: kvm: Don't abuse host r2 in exit path
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87lhzilign.fsf@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 11:30:08 +0100
Message-Id: <6AAAB4B6-5BBD-41E4-9640-DACC9DFDF69D@suse.de>
References: <1384178387-22993-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87lhzilign.fsf@linux.vnet.ibm.com>
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


On 18.12.2013, at 08:35, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

>=20
> Hi Alex,
>=20
> Any update on this ? We need this to got into 3.13.

Thanks, applied to for-3.13.


Alex
