Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 48810DDF36
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 05:47:36 +1100 (EST)
Date: Fri, 18 Jan 2008 10:47:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080117211511.GA25320@aepfle.de>
Message-ID: <Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008, Olaf Hering wrote:

> early_node_map[1] active PFN ranges
>     1:        0 ->   892928
> Could not find start_pfn for node 0

Corrupted min_pfn?
