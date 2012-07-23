Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77C172C0334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 16:48:41 +1000 (EST)
Message-ID: <1343026108.2957.28.camel@pasglop>
Subject: Re: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va
 in tlb invalidate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2012 16:48:28 +1000
In-Reply-To: <87d33nht7x.fsf@skywalker.in.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
 <1343006528.29855.25.camel@pasglop> <20120723034912.GA5019@drongo>
 <87d33nht7x.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 12:14 +0530, Aneesh Kumar K.V wrote:
> 
> if it is 0.. 15 then that clear bit is wrong right ? We are doing that
> on a 64 bit va. So with that we already have ignored 0..14. 

It's bit 0..15 of RB passed to tlbie

Cheers,
Ben.
