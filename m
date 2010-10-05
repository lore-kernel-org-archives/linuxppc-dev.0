Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 04719B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:19:48 +1100 (EST)
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o955Jl9f029031 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 5 Oct 2010 14:19:48 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E5C645DE4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:19:47 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 391A345DE57
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:19:47 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 113621DB805D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:19:47 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 806E2E38001
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 14:19:46 +0900 (JST)
Date: Tue, 5 Oct 2010 14:14:27 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/9] v3 rename phys_index properties of memory block struct
Message-Id: <20101005141427.e5fafa25.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4CA62982.5080900@austin.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62982.5080900@austin.ibm.com>
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

On Fri, 01 Oct 2010 13:33:38 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the 'phys_index' property of a the memory_block struct to be
> called start_section_nr, and add a end_section_nr property.  The
> data tracked here is the same but the updated naming is more in line
> with what is stored here, namely the first and last section number
> that the memory block spans.
> 
> The names presented to userspace remain the same, phys_index for
> start_section_nr and end_phys_index for end_section_nr, to avoid breaking
> anything in userspace.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
