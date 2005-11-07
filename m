Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 8F1CE6869D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 01:45:15 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jA7ErGJL027516
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Nov 2005 16:53:17 +0200 (EET)
Message-ID: <436F6724.8010702@intracom.gr>
Date: Mon, 07 Nov 2005 16:39:32 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
In-Reply-To: <20051107084431.GA15180@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Hi folks,
> 
> Seems the bug is exposed by the change which avoids flushing the
> TLB when not necessary (in case the pte has not changed), introduced
> recently:
> 

[snip]

> 
> 

Good job Marcelo! :)

FWIW I'd rather have the single exception version if at all possible.

Regards

Pantelis
