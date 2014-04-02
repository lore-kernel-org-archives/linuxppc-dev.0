Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0786D1400E4
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 14:41:57 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 09:11:54 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 321CF1258048
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 09:14:21 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s323fuMv3539422
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2014 09:11:56 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s323fpGW013725
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2014 09:11:51 +0530
Message-ID: <533B86A5.90700@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2014 09:10:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [RFC] powerpc, ptrace: Add few more ptrace request macros
References: <1396350893-4456-1-git-send-email-khandual@linux.vnet.ibm.com>
 <25834.1396399387@ale.ozlabs.ibm.com>
In-Reply-To: <25834.1396399387@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2014 06:13 AM, Michael Neuling wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
>> > This patch adds few more ptrace request macros expanding
>> > the existing capability. These ptrace requests macros can
>> > be classified into two categories.
> Why is this only an RFC?
> 

Looking for comments, suggestions, concerns from people. But looks
like its bit big a patch to review at once.

> Also, please share the test case that you wrote for this.

Will split the patch into multiple components, add the test case
and send out again.
