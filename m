Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69DC02C0617
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 20:41:58 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 5B89D1793210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:18 +0900 (JST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EC1FE3EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:12 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D1DE445DEC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A914C45DEBE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 95E591DB8048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:12 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 490031DB8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:49:12 +0900 (JST)
Message-ID: <50A4AC67.5000102@jp.fujitsu.com>
Date: Thu, 15 Nov 2012 17:48:39 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>
Subject: Re: [patch 4/4] mm, oom: remove statically defined arch functions
 of same name
References: <alpine.DEB.2.00.1211140111190.32125@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1211140113480.32125@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1211140113480.32125@chino.kir.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2012/11/14 18:15), David Rientjes wrote:
> out_of_memory() is a globally defined function to call the oom killer.
> x86, sh, and powerpc all use a function of the same name within file
> scope in their respective fault.c unnecessarily.  Inline the functions
> into the pagefault handlers to clean the code up.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: David Rientjes <rientjes@google.com>

I think this is good.

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
