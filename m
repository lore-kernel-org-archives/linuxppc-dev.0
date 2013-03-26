Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp01.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E20F2C017E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:32:54 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 14:32:49 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E70EB3520055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 13:32:45 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QHW0Jp23003278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 14:32:00 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QFX8j4016375
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 12:33:08 -0300
Received: from [9.18.239.167] (carranca.br.ibm.com [9.18.239.167])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2QFX8OM016372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 12:33:08 -0300
Message-ID: <5151DBBD.4090705@linux.vnet.ibm.com>
Date: Tue, 26 Mar 2013 14:32:45 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <1363755620.18880.27.camel@pasglop> <514B0DCD.5020209@linux.vnet.ibm.com>
In-Reply-To: <514B0DCD.5020209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Just sending a ping about this patch.

On 21-03-2013 10:40, Adhemerval Zanella wrote:
> On 20-03-2013 02:00, Benjamin Herrenschmidt wrote:
>> On Tue, 2013-03-19 at 16:55 -0300, Adhemerval Zanella wrote:
>>> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
>>> as well?
>> You did provide both 32 and 64-bit VDSO implementations so 32-bit
>> kernels should be covered.
> Indeed and thanks for the reply. Any objection or request about including it?
>
> Thanks.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
