Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 39B97B6EEF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:51:03 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o754p2iw032485 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 5 Aug 2010 13:51:02 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A8C945DE70
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:51:02 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 39BE145DE6E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:51:02 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 115B61DB8042
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:51:02 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B85FE1DB803F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:51:01 +0900 (JST)
Date: Thu, 5 Aug 2010 13:45:46 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/9] v4  Move the find_memory_block() routine up
Message-Id: <20100805134546.fa8f2f96.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C581B67.1010202@austin.ibm.com>
References: <4C581A6D.9030908@austin.ibm.com> <4C581B67.1010202@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Aug 2010 08:36:39 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Move the find_memory_block() routine up to avoid needing a forward
> declaration in subsequent patches.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
