Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 069692C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:13:16 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Sat, 3 Aug 2013 00:34:50 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 558DCE004F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 00:43:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72JEG8932768138
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 00:44:16 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r72JD9AP031942
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 05:13:10 +1000
Message-ID: <51FC04C2.70100@linux.vnet.ibm.com>
Date: Fri, 02 Aug 2013 14:13:06 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/8] Add all memory via sysfs probe interface at once
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EFB.6070207@linux.vnet.ibm.com> <20130802023259.GC1680@concordia>
In-Reply-To: <20130802023259.GC1680@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm <linux-mm@kvack.org>, isimatu.yasuaki@jp.fujitsu.com,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2013 09:32 PM, Michael Ellerman wrote:
> On Wed, Jul 24, 2013 at 01:37:47PM -0500, Nathan Fontenot wrote:
>> When doing memory hot add via the 'probe' interface in sysfs we do not
>> need to loop through and add memory one section at a time. I think this
>> was originally done for powerpc, but is not needed. This patch removes
>> the loop and just calls add_memory for all of the memory to be added.
> 
> Looks like memory hot add is supported on ia64, x86, sh, powerpc and
> s390. Have you tested on any?

I have tested on powerpc. I would love to say I tested on the other
platforms... but I haven't.  I should be able to get a x86 box to test
on but the other architectures may not be possible.

-Nathan
