Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DE882BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 02:33:58 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0410081142300.14235@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080840520.6091@dell.enoriver.com>
	<7D7D70F5-193F-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008154631.GA14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410081142300.14235@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1E7AC867-1948-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 12:35:52 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: next pass of cleaning up micropatch.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 11:45 AM, Robert P. J. Day wrote:

> i'll put the actual code back in, but you might have second thoughts 
> when we're up to 8 or 10 patches some day. :-)

No, I won't.  I'm an old school engineer that believes writing software
is as much art as engineering.  Macros have their place, but only
when appropriate.  The only thing I hate more than macros is
code in include files.  Instead of those macros, I would have written
a simple function that takes a microcode patch array, #define'd
those hard coded addresses with logical names and passed it
into that function.

Thanks.


	-- Dan
