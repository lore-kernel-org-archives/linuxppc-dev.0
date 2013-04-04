Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 887752C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 06:23:21 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 16:23:12 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0EB6B1DC004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 15:23:01 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r34JKaSP1368258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 16:20:36 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r34HMjXW026283
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 14:22:46 -0300
Message-ID: <515DD313.3050505@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:22:59 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <1363755620.18880.27.camel@pasglop>
In-Reply-To: <1363755620.18880.27.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

Any objection or request about this patch?


On 20-03-2013 02:00, Benjamin Herrenschmidt wrote:
> On Tue, 2013-03-19 at 16:55 -0300, Adhemerval Zanella wrote:
>> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
>> as well?
> You did provide both 32 and 64-bit VDSO implementations so 32-bit
> kernels should be covered.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
