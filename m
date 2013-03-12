Return-Path: <benh@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74C4A2C029F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 14:03:11 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 12 Mar 2013 12:56:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ADD13357804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 14:02:52 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2C32mGe4260186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 14:02:49 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2C32pSn022108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 14:02:52 +1100
Message-ID: <1363057371.4534.9.camel@pasglop>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 12 Mar 2013 14:02:51 +1100
In-Reply-To: <87d2v5mihn.fsf@linux.vnet.ibm.com>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87d2v5mihn.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, geoff@infradead.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-03-12 at 08:28 +0530, Aneesh Kumar K.V wrote:
> Ben, Paul,
> 
> Any update on this ? 

Paul and David are reviewing it and I was trying to test on POWER3 (STAB
vs. SLB) but ended up bisecting instead why POWER3 stopped working in
3.4 ... :-)

Cheers,
Ben.
