Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id B55182BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 06:53:27 +1000 (EST)
Date: Fri, 8 Oct 2004 16:46:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <1E7AC867-1948-11D9-9299-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0410081643100.25430@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080840520.6091@dell.enoriver.com>
	<7D7D70F5-193F-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008154631.GA14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410081142300.14235@dell.enoriver.com>
	<1E7AC867-1948-11D9-9299-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Fri, 8 Oct 2004, Dan Malek wrote:

>
> On Oct 8, 2004, at 11:45 AM, Robert P. J. Day wrote:
>
>> i'll put the actual code back in, but you might have second thoughts when 
>> we're up to 8 or 10 patches some day. :-)
>
> ... Instead of those macros, I would have written a simple function 
> that takes a microcode patch array, #define'd those hard coded 
> addresses with logical names and passed it into that function.

nice idea, but sadly, doomed to failure.  note that the code to copy 
the patch arrays *requires* you to be able to take the sizeof() those 
arrays to know *exactly* how much to copy.  if you pass the array to a 
function by its address, i'm pretty sure you lose the ability to take 
its sizeof() anymore, isn't that right?

in short, you either need the code or a macro representing the code. 
a function won't help you here.

rday
