Return-Path: <anton@samba.org>
Date: Thu, 9 Jan 2014 01:17:49 +1100
From: Anton Blanchard <anton@samba.org>
To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140109011749.6888b57d@kryten>
In-Reply-To: <20140107041939.GA20916@hacker.(null)>
References: <20140107132100.5b5ad198@kryten>
 <20140107041939.GA20916@hacker.(null)>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cl@linux-foundation.org, nacc@linux.vnet.ibm.com, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, mpm@selenic.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Wanpeng,

> >+		if (node_spanned_pages(node)) {
> 
> s/node_spanned_pages/node_present_pages 

Thanks, I hadn't come across node_present_pages() before.

Anton
