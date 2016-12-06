Return-Path: <dave.hansen@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYGmZ1GL3zDvkB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 09:40:29 +1100 (AEDT)
Subject: Re: next-20161206 WARN@ mm/hugetlb.c:2918 during boot
To: Balbir Singh <bsingharora@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <70A62042-92E6-414D-8FBD-BA0F5308944B@linux.vnet.ibm.com>
 <20161207092721.270fbc43@canb.auug.org.au>
 <CAKTCnzmxjf+v3t-o7GwZkWp1Wrff+o0B6CAt0Ehp8gv3pdQTOA@mail.gmail.com>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 linux-next <linux-next@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ef890d7f-2918-4848-e77d-b10f528b7afe@intel.com>
Date: Tue, 6 Dec 2016 14:40:25 -0800
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmxjf+v3t-o7GwZkWp1Wrff+o0B6CAt0Ehp8gv3pdQTOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2016 02:37 PM, Balbir Singh wrote:
> I think Michael found this as well, its related to adding our gigantic
> page to the hugetlb list
> and the WARN_ON that Dave Hansen added (commit
> a3a18061c987aa9da4f5d3cbb31a9e71e9d7191d)
> 
> I've not looked at this issue yet, Aneesh is aware of the issue as well

It's harmless, and I believe Andrew pulled it out of -mm.  So, just
ignore it for now.

Thanks for the report, though.
