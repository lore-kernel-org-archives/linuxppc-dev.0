Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id D5B2E2BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:03:53 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8LB45Tl023316
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 14:04:06 +0300 (EEST)
Message-ID: <4150056E.9050300@intracom.gr>
Date: Tue, 21 Sep 2004 13:41:50 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Song Sam <samlinuxppc@yahoo.com.cn>
References: <20040921103503.54102.qmail@web15607.mail.cnb.yahoo.com>
In-Reply-To: <20040921103503.54102.qmail@web15607.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Song Sam wrote:

>Pantelis Antoniou <panto@intracom.gr> wrote£º
>
>>Well it works OK until it gets to start init.
>>
>>Then it crashes the way it is supposed to :).
>>
>>Tom I think it's the problem we are talking about.
>>
>>Song please try this...
>>
>
>Guess what? It WORKED!!! Just one more line make it.
>Could you pls tell us the theory in it if not too
>complicated? :-)
>
>Well Done!
>
Oh man Dan will kill me :)

The theory is simple, TLB handling is faulty for 8xx.

This patch fixes it but Dan & Ben think it's just by
coincedence and we should fix it properly.

Regards

Pantelis
