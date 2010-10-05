Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id AADC1B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:30:03 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o9556sM0021430 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:06:54 +0900
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o9556oi6023280 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:06:50 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 089BE45DE51
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:06:50 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D302045DE4E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:06:49 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BF5501DB8038
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:06:49 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7DE6C1DB803A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:06:49 +0900 (JST)
Date: Tue, 5 Oct 2010 14:01:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/9] v3 Move find_memory_block routine
Message-Id: <20101005140110.4bb65741.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4CA62857.4030803@austin.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62857.4030803@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 01 Oct 2010 13:28:39 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Move the find_memory_block() routine up to avoid needing a forward
> declaration in subsequent patches.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
Reviewd-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
