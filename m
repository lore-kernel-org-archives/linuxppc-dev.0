Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEA932C0299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 11:41:53 +1100 (EST)
Message-ID: <1363048897.3155.16.camel@smoke>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
From: Geoff Levand <geoff@infradead.org>
To: benh@kernel.crashing.org
Date: Mon, 11 Mar 2013 17:41:37 -0700
In-Reply-To: <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2013-02-15 at 21:09 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
> we have boot hangs on platforms that only support 65 bit VA.

I didn't seen this fix go in for 3.8.  Did I miss it, or is there some
reason we don't want it?

I need this to boot PS3.

-Geoff
