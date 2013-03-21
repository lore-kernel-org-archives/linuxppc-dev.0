Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB8022C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 00:40:43 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Thu, 21 Mar 2013 10:40:33 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 78CFE3520060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 09:40:30 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2LDcInv2228236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 10:38:18 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2LDeTlO026687
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 10:40:29 -0300
Received: from [9.18.239.243] (carranca.br.ibm.com [9.18.239.243])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2LDeTmV026684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 10:40:29 -0300
Message-ID: <514B0DCD.5020209@linux.vnet.ibm.com>
Date: Thu, 21 Mar 2013 10:40:29 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <1363755620.18880.27.camel@pasglop>
In-Reply-To: <1363755620.18880.27.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20-03-2013 02:00, Benjamin Herrenschmidt wrote:
> On Tue, 2013-03-19 at 16:55 -0300, Adhemerval Zanella wrote:
>> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
>> as well?
> You did provide both 32 and 64-bit VDSO implementations so 32-bit
> kernels should be covered.

Indeed and thanks for the reply. Any objection or request about including it?

Thanks.
