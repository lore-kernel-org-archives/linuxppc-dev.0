Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 642F61A0211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:09:39 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 17:09:36 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CE9F8C90048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:00:36 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GL9XkM59900092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 21:09:33 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GL9VGo017784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:09:32 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 01/30] cxlflash: Fix to avoid invalid port_sel value
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1442431127.2234.28.camel@HansenPartnership.com>
Date: Wed, 16 Sep 2015 16:09:29 -0500
Cc: linux-scsi@vger.kernel.org, nab@linux-iscsi.org, brking@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, dja@ozlabs.au.ibm.com,
 andrew.donnellan@au1.ibm.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, Manoj Kumar <kumarmn@us.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <C47C20BA-B972-4193-950C-07A4A547503A@linux.vnet.ibm.com>
References: <1442422317-40957-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442431127.2234.28.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 16, 2015, at 2:18 PM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> Could you please add a cover letter (a 0/30) and thread your patches
> from that?  For large patch series, it really does make following
> everything a lot easier for me (and most other people who use a =
threaded
> mail reader).

James,

My mistake. I'll send out a properly threaded series shortly.


-matt=
