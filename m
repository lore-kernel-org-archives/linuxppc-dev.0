Return-Path: <anton@ozlabs.org>
Date: Tue, 23 Feb 2010 12:38:38 +1100
From: Anton Blanchard <anton@samba.org>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
Message-ID: <20100223013838.GF31681@kryten>
References: <20100218222923.GC31681@kryten>
	<661de9471002190743t5385d97hf38c544f0007879c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <661de9471002190743t5385d97hf38c544f0007879c@mail.gmail.com>
Cc: mel@csn.ul.ie, cl@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Balbir,

> A reclaim distance of 10 implies a ratio of 1, that means we'll always
> do zone_reclaim() to free page cache and slab cache before moving on
> to another node?

I want to make an effort to reclaim local pagecache before ever going
off node. As an example, a completely off node stream result is almost 3x
slower than on node on my test box.

Anton
