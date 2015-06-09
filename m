Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F8E61A02D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 15:41:22 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED7BA140331
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2015 15:41:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 9 Jun 2015 11:11:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3A3B73940048
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2015 11:11:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t595fEvp1638894
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jun 2015 11:11:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t594mkaC006734
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jun 2015 10:18:46 +0530
Message-ID: <55767C79.1060905@linux.vnet.ibm.com>
Date: Tue, 09 Jun 2015 11:11:13 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 10/10] selftests, powerpc: Add test for BHRB branch
 filters (HW & SW)
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2015 05:08 PM, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

This should be "Anshuman Khandual <khandual@linux.vnet.ibm.com>" and it happened
to couple of other patches in this series as well. I believe it got messed up in
a test machine, will fix it next time around.
