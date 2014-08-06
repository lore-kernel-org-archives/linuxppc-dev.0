Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93A941A071C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 00:46:28 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 00:46:26 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2AEE92BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 00:46:24 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s76ENFMo42008622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 00:23:15 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s76EkNbL023654
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 00:46:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: thp: Use tlbiel wherever possible
In-Reply-To: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 06 Aug 2014 20:16:20 +0530
Message-ID: <8738d965hf.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> If we know that user address space has never executed on other cpus
> we could use tlbiel.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Now checking against flush_hash_page, I am wondering whether I need to handle
transcational memory in case of tlbiel ? Michael, can you let me know if
this is needed ?


-aneesh
