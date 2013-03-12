Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 619D62C0293
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 07:11:55 +1100 (EST)
Message-ID: <1363119103.3155.27.camel@smoke>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
From: Geoff Levand <geoff@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 12 Mar 2013 13:11:43 -0700
In-Reply-To: <87vc8xrsp1.fsf@linux.vnet.ibm.com>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130312042547.GC9351@truffula.fritz.box>
 <87vc8xrsp1.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On Tue, 2013-03-12 at 12:49 +0530, Aneesh Kumar K.V wrote:
> Done. I added this as a patch on top of the series. 

I tried to test this against v3.8, but applying it failed:

 Applying: powerpc: Update kernel VSID range
 error: patch failed: arch/powerpc/mm/slb_low.S:66

Could you please make a set that applies to 3.8?  Thanks.

-Geoff
