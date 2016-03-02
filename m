Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A3FA1A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:05:55 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F160B1402DE
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 20:05:54 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 19:05:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 41A7E2CE805A
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 20:05:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2295g1n852364
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 20:05:50 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2295Hsr024710
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 20:05:17 +1100
Message-ID: <56D6ACBC.90604@linux.vnet.ibm.com>
Date: Wed, 02 Mar 2016 14:35:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 18/28] selftests, powerpc: Add ptrace tests for GPR/FPR
 registers
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-19-git-send-email-khandual@linux.vnet.ibm.com>
 <20160302114001.64f8adbb@camb691>
In-Reply-To: <20160302114001.64f8adbb@camb691>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2016 06:10 AM, Cyril Bur wrote:
> On Tue, 16 Feb 2016 14:29:48 +0530
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> > This patch adds ptrace interface test for GPR/FPR registers.
>> > This adds ptrace interface based helper functions related to
>> > GPR/FPR access and some assembly helper functions related to
>> > GPR/FPR registers.
>> > 
> I wonder if with a bit of thought we could share our assembly helper
> functions... https://patchwork.ozlabs.org/patch/589703/
> 
> Let me know, happy to meet in the middle and augment my series if needed.

Let me look into this in detail, will need some time.
