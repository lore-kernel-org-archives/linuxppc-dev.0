Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56C671A0A69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 16:10:45 +1100 (AEDT)
Date: Thu, 18 Dec 2014 16:10:43 +1100
From: Anton Blanchard <anton@samba.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [1/5] powerpc: Fix handling of DSCR related facility
 unavailable exception
Message-ID: <20141218161043.52b5367c@kryten>
In-Reply-To: <5486F607.6010706@linux.vnet.ibm.com>
References: <20141209101117.1CEC9140100@ozlabs.org>
 <5486F607.6010706@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

> Yeah I wanted to convert all these tests which are related to DSCR
> into individual self tests for powerpc. All these test cases have
> Anton Blanchard and IBM's copyright on it but they are licensed with
> GPL V2. Not sure whether Anton needs to okay this before I can modify
> them for self tests, put his (Anton's) signed-off-by and then post it
> in the mailing list.
> 
> (1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
> (2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
> (3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
> (4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
> (5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c

I'm happy for the testcases to be modified and merged into the kernel!

When you submit them I'll give them a once over and attach my
Signed-off-by.

Thanks,
Anton
