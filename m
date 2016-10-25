Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t37R91msQzDvh9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 20:39:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/5] powerpc/mm: allow memory hotplug into a memoryless
 node
In-Reply-To: <872f253d-8a55-246c-2be0-636a588e2dd0@gmail.com>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-4-git-send-email-arbab@linux.vnet.ibm.com>
 <872f253d-8a55-246c-2be0-636a588e2dd0@gmail.com>
Date: Tue, 25 Oct 2016 20:39:45 +1100
Message-ID: <87pomoydge.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:
> FYI, these checks were temporary to begin with
>
> I found this in git history
>
> b226e462124522f2f23153daff31c311729dfa2f (powerpc: don't add memory to empty node/zone)

Nice thanks for digging it up.

  commit b226e462124522f2f23153daff31c311729dfa2f
  Author:     Mike Kravetz <kravetz@us.ibm.com>
  AuthorDate: Fri Dec 16 14:30:35 2005 -0800
                                  ^^^^
                                  
That is why maintainers don't like to merge "temporary" patches :)

cheers
