Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFhpQ2RgRzDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 13:19:09 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id x7so14703339pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 19:19:09 -0700 (PDT)
Date: Mon, 16 Oct 2017 13:18:58 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/perf/imc: use NUMA_NO_NODE for
 alloc_pages_node
Message-ID: <20171016131858.73b37570@firefly.ozlabs.ibm.com>
In-Reply-To: <1508093022-11496-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1508093022-11496-2-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 16 Oct 2017 00:13:42 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> alloc_pages_node() when passed NUMA_NO_NODE for the
> node_id, could get memory from closest node. Cleanup
> core imc and thread imc memory init functions to use
> NUMA_NO_NODE.


The changelog is not clear, alloc_pages_node() takes a
preferred node id and creates a node zonelist from it.
How is NUMA_NO_NODE better? 

Balbir Singh.
