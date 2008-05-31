Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-148.bluehost.com (outbound-mail-148.bluehost.com
	[67.222.38.38]) by ozlabs.org (Postfix) with SMTP id 44802DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jun 2008 04:34:38 +1000 (EST)
Message-ID: <48419A3A.3070301@dlasys.net>
Date: Sat, 31 May 2008 14:34:34 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Error occured when appended FPGA image in the section of
	.init.text then bootup
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>	<4841270B.9080805@nishioka.com>	<484185E9.6040207@dlasys.net>
	<20080531125753.779c56e6@zod.rchland.ibm.com>
In-Reply-To: <20080531125753.779c56e6@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 I do not think the patch in question is board specific.
It has been arround for a long time. And I think alot of people have
been bitten by the problem.
It is required for my board.
I think it is required for any board that generates a large enough image.
I would be happy to signoff on it - it works/is necescary on my board.

I can not seem to find the same code in arch/powerpc so I have no clue
whether something similar might be needed there.


Josh Boyer wrote:
> On Sat, 31 May 2008 13:07:53 -0400
> "David H. Lynch Jr." <dhlii@dlasys.net> wrote:
>
>   
>> Is there some reason this patch is not getting pushed into mainline ?
>>     
>
> Lacks Signed-off-by, support for the board in question doesn't even
> exist in arch/ppc anymore, and arch/ppc is going away in June.
>
> josh
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
