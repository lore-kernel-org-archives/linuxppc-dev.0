Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.co.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 4D2192BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 21:15:14 +1000 (EST)
Message-ID: <415D3C2C.7050704@jonmasters.org>
Date: Fri, 01 Oct 2004 12:14:52 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>	
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<1096602008.14803.16.camel@gaston>
In-Reply-To: <1096602008.14803.16.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> On Fri, 2004-10-01 at 13:11, Kumar Gala wrote:

>>I've been told that ARM has a solution, in place, to this problem that 
>>might always be worth looking at.

I asked on their mailing list a while ago in preparation but I think Ben 
has the best approach.

> I'd rather see you guys sync with what I did on ppc64 and use that 
> kind of OF device-tree, we already have all the code for using it
> and it would make the mecanism compatible with the prep/chrp/pmac
> kernel...

Yeah. I'm going to start ripping through your code at the weekend and 
figure out how what you've done - not having a nice shiney ppc64 box 
means I've not yet got an excuse to play with that tree myself. I am 
however hopefull that my next Powerbook will be a G5 :-).

> But that's just a suggestion...

Taken.

Jon.
