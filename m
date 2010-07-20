Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 28AB1B6EE9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:22:10 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K7M9FI023493 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:22:10 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A68D945DE50
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:22:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8684245DE4E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:22:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 74E471DB8040
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:22:09 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 302091DB8037
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:22:09 +0900 (JST)
Date: Tue, 20 Jul 2010 16:17:26 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 6/8] v3 Update the node sysfs code
Message-Id: <20100720161726.7b223681.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451EAF.1080505@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451EAF.1080505@austin.ibm.com>
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

On Mon, 19 Jul 2010 22:57:35 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the node sysfs code to be aware of the new capability for a memory
> block to contain multiple memory sections.  This requires an additional
> parameter to unregister_mem_sect_under_nodes so that we know which memory
> section of the memory block to unregister.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
