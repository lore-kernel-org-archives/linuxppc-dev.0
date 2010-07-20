Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 8EF29B70AE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:02:27 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K72QB4014287 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:02:26 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0854945DE51
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:02:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DD67345DE4E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:02:25 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C3A1A1DB803B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:02:25 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 81ADE1DB803A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:02:25 +0900 (JST)
Date: Tue, 20 Jul 2010 15:57:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/8] v3 Add new phys_index properties
Message-Id: <20100720155745.de079d69.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451D92.6020406@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451D92.6020406@austin.ibm.com>
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

On Mon, 19 Jul 2010 22:52:50 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the 'phys_index' properties of a memory block to include a
> 'start_phys_index' which is the same as the current 'phys_index' property.
> This also adds an 'end_phys_index' property to indicate the id of the
> last section in th memory block.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

No, please remain "phys_index" as it is. please don't rename it.
IMHO, just adding end_phys_index is better.
please avoid interface change AFAP.

Do you have a problem if phys_index means start_phys_index ?

Thanks,
-Kame
