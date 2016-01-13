Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 838361A0754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:48:33 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 65so5513095pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:48:33 -0800 (PST)
Date: Wed, 13 Jan 2016 13:48:21 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Michael
 Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 01/33] powerpc/mm: add _PAGE_HASHPTE similar to
 4K hash
Message-ID: <20160113134821.41d4e006@cotter.ozlabs.ibm.com>
In-Reply-To: <1452582968-22669-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jan 2016 12:45:36 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Not really needed. But this brings it back to as it was before
> 

Could you expand on not really needed. Could the changelog describe how
the bits will be used in the follow on patches.

Balbir
