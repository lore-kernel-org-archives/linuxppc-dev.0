Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 2D473DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 05:01:15 +1100 (EST)
In-Reply-To: <478F6DB6.8050907@gmail.com>
To: Ben Warren <biggerbadderben@gmail.com>
Subject: Re: Endian problem when accessing internel regs on 8347
MIME-Version: 1.0
Message-ID: <OF5F228537.B04EB840-ON882573D3.00628576-882573D3.0062FB1E@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 17 Jan 2008 10:01:09 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ben Warren <biggerbadderben@gmail.com> wrote on 01/17/2008 07:01:10 AM:

> > 
> I've attached a poorly-written-yet-functional GPIO driver that I wrote a 

> while ago for the MPC8349 (same as what you have for all intents and 
> purposes). It uses in_be32() and out_be32().
> 
Ben,

Thanks for the answer.  Hummmm, at first glance it looks like you're doing 
the same thing I am.  Only difference I can see is you use get_immrbase() 
to figure out the address to ask for and I've got it hardcoded.  Other 
than that we're both using request_mem_region() in in/out_be32().  Yet 
your's works for you and mine doesn't.  Well, I'll take a closer look 
tonight and see if there's something you're doing that I missed. 
Unfortunately, I've gotten a higher level interrupt this morning and it 
may ba a day or so before I get back to this and can give you any 
feedback.  Thanks again.

See 'ya!

Bruce
