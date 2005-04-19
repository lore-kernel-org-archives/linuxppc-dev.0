Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8293C67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 02:57:33 +1000 (EST)
In-Reply-To: <20050419115253.GA2780@logos.cnet>
References: <20050419115253.GA2780@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <305099d2198de69f3cb25ce1a5074bde@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 19 Apr 2005 12:57:18 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: update DataTLBMiss exception comment
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 19, 2005, at 7:52 AM, Marcelo Tosatti wrote:

> Since v2.6 DataTLBMiss doesnt jump to the page fault handler, it 
> instead
> loads invalid TLB which in turn causes a DataTLBError exception.

Which, of course, is the logically correct way to do it.  I guess I just
read too much into the suggestion in the manual to jump to the
"unused" Data Error exception vector under some miss conditions.
I tried to eliminate the immediate error fault that was going to
happen, but I guess we have to force that fault to get the proper
information in the fault registers.

> The comment on top of it haven't been update since the change.
>
> What about this?

Yes, thanks.


	-- Dan
