Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 42D03B70B4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:21:16 +1000 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K7LEYf011357 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:21:15 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id A84CB45DE50
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:21:14 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CF4845DE4E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:21:14 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 78AAD1DB8013
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:21:14 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 2AB1E1DB8015
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:21:11 +0900 (JST)
Date: Tue, 20 Jul 2010 16:16:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/8] v3 Update the find_memory_block declaration
Message-Id: <20100720161629.1551837f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451E60.8080702@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451E60.8080702@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Jul 2010 22:56:16 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the find_memory_block declaration to to take a struct mem_section *
> so that it matches the definition.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Reviewd-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
