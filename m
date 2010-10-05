Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail9.fujitsu.co.jp (fgwmail9.fujitsu.co.jp [192.51.44.39])
	by ozlabs.org (Postfix) with ESMTP id A0B0EB6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:30:03 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o955BUIa025361 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:11:30 +0900
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o955BTkL025510 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:11:29 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3DBC745DE55
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:11:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E50C45DE51
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:11:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 06B8F1DB803B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:11:29 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B651E1DB803A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:11:28 +0900 (JST)
Date: Tue, 5 Oct 2010 14:06:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/9] v3 Add mutex for adding/removing memory blocks
Message-Id: <20101005140604.6bbd8ae0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4CA62896.2060307@austin.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62896.2060307@austin.ibm.com>
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

On Fri, 01 Oct 2010 13:29:42 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Add a new mutex for use in adding and removing of memory blocks.  This
> is needed to avoid any race conditions in which the same memory block could
> be added and removed at the same time.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
Reviewed-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
