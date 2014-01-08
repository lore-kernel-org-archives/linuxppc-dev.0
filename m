Return-Path: <anton@samba.org>
Date: Thu, 9 Jan 2014 01:03:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140109010358.0f9b30c4@kryten>
In-Reply-To: <871u0k5lri.fsf@tassilo.jf.intel.com>
References: <20140107132100.5b5ad198@kryten>
 <871u0k5lri.fsf@tassilo.jf.intel.com>
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


Hi Andi,

> > Thoughts? It seems like we could hit a similar situation if a
> > machine is balanced but we run out of memory on a single node.
> 
> Yes I agree, but your patch doesn't seem to attempt to handle this?

It doesn't. I was hoping someone with more mm knowledge than I could
suggest a lightweight way of doing this.

Anton
