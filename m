Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBB111A177B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 22:34:00 +1100 (EST)
Message-ID: <1412681640.4133.0.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v3 01/16] powerpc/cell: Move spu_handle_mm_fault() out
 of cell platform
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 07 Oct 2014 22:34:00 +1100
In-Reply-To: <20141007220855.75b64a57@canb.auug.org.au>
References: <1412678902-18672-1-git-send-email-mikey@neuling.org>
 <1412678902-18672-2-git-send-email-mikey@neuling.org>
 <20141007220855.75b64a57@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > +int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *v=
sid);
>=20
> This function is otherwise not included in this patch, so it should
> probably be removed (as the next patch removes it anyway).

Yeah, looks like I screwed it up slightly in the packing of these
patches.

Thanks.
Mikey
