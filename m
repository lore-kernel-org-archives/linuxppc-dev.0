Message-ID: <3C0E5FB1.4020108@embeddededge.com>
Date: Wed, 05 Dec 2001 12:56:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: scop@digitel.com.br
Cc: linuxppc-embedded@lists.linuxppc.org, andy_lowe@mvista.com
Subject: Re: Kernel oops while routing
References: <3C06B9D0.7020804@embeddededge.com> <917.011205@digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> So, we're offering this patch to the public list (with Andy's
> blessing :-). I can provide any other details about our tests, if
> required.

Cool.  Thanks.  This could also be a problem with all Ethernet drivers
(SCC, FCC, and FEC) on both 8xx and 8260.  I'll look at the others.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
