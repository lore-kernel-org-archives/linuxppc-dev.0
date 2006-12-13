Return-Path: <Geoff.Thorpe@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4F54B67B77
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:25:35 +1100 (EST)
Message-ID: <457F8EC3.60201@freescale.com>
Date: Wed, 13 Dec 2006 00:25:23 -0500
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>	<1165890570.11914.5.camel@localhost.localdomain>	<457F1F6E.4020502@freescale.com>	<1165960058.11914.72.camel@localhost.localdomain>	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>	<20061212162416.06f0dd76.kim.phillips@freescale.com>	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>	<457F2FE1.1080308@freescale.com>
	<513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
In-Reply-To: <513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>It adds code to all those people that don't need it just so we don't  
>duplicate a few lines of source code.
>  
>

Sounds like you're describing the raison d'être for device-trees though? 
After all, if you want to build a kernel that supports these minor h/w 
variations depending on the device-tree it's booted with, then the "few 
lines of duplicated source code" you're talking about would also "add 
code to all those people that don't need it".

Kumar Gala also wrote:

>On Dec 12, 2006, at 4:41 PM, Scott Wood wrote:
>  
>
>>And an 83xx-generic machine description does not stop them from  
>>doing so.  "Generic" does not mean "universal".  It means "there's  
>>nothing special about this board".  If you need board-specific code  
>>in the kernel, then don't label it generic.
>>    
>>
>
>But what value does this have?  83xx, and the majority of freescale's  
>devices are not put into something as standard as a desktop computer.
>  
>

Then what value do device-trees have at all? Why require new code for 
new h/w if it's technically unnecessary? If I've understood correctly (I 
confess to not having followed all of the discussion nor the finer 
technical points), this would require new code to find its way 
"upstream" (to whoever/wherever/whatever that means) from freescale and 
then downstream to it's user before the h/w is supported, when this 
situation is precisely what device-trees apparently ought to resolve.

Maybe I'm missing something (quite possible). Ben's objection seemed to 
be one of naming, but yours seems to be that new h/w should require new 
code because it's not wintel fodder for desktop grannies? So why bother 
separating h/w description from the compiled kernel in the first place?

Cheers,
Geoff
