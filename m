Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 325E72C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:14:57 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 19 Nov 2012 16:10:52 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAJ64PeV64553072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:04:25 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAJ6Er3J012035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:14:54 +1100
Message-ID: <50A9CE6A.3080208@linux.vnet.ibm.com>
Date: Mon, 19 Nov 2012 11:45:06 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc, perf: Change PMU flag values representation
 from decimal to hex
References: <1353056344-1392-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20121116114219.GA5745@bloggs.ozlabs.ibm.com>
In-Reply-To: <20121116114219.GA5745@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, michael.neuling@au1.ibm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2012 05:12 PM, Paul Mackerras wrote:
> On Fri, Nov 16, 2012 at 02:29:04PM +0530, Anshuman Khandual wrote:
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> That's not a sufficient description of why you are making this
> change.  In particular, what is the motivation for and impact of using
> LONG_ASM_CONST?
> 
> Paul.

Hey Paul,

I have just sent out a revised patch where I have updated the description
and dropped the usage of LONG_ASM_CONST.

Regards
Anshuman 
 
