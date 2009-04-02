Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BE78FDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 07:45:57 +1100 (EST)
Message-ID: <49D523FB.2020504@nortel.com>
Date: Thu, 02 Apr 2009 14:45:47 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Resend: /proc/<pid>/maps offset output broken in 2.6.29
References: <49CA8501.1000000@nortel.com> <49D3F662.4050100@nortel.com>
	<1238659491.9041.133.camel@localhost>
	<Pine.LNX.4.64.0904021324070.16207@blonde.anvils>
	<49D4FB89.4070101@nortel.com>
	<Pine.LNX.4.64.0904021938270.25731@blonde.anvils>
In-Reply-To: <Pine.LNX.4.64.0904021938270.25731@blonde.anvils>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hugh Dickins wrote:

> This is a cosmetic matter, not worth more than a couple of lines of
> code: I suggested masking off the high bits in the display, but when
> KAMEZAWA-san suggested just showing 0, it was hard to argue against
> his brutal simplicity.

<snip>

> Consider this change a fix: it used to show 00000000 before 2.6.7.
> 
> See http://lkml.org/lkml/2009/1/13/331 for one of the threads
> on the subject - but you've not tempted me to reopen it!

Okay, fair enough.  I'll change my code to deal with it.  Thanks for the 
explanation.

Chris
