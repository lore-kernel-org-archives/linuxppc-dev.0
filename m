Return-Path: <jwilliams@itee.uq.edu.au>
Received: from mailhub3.uq.edu.au (mailhub3.uq.edu.au [130.102.148.131])
	by ozlabs.org (Postfix) with ESMTP id 97B81DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 15:46:59 +1100 (EST)
Message-ID: <47392A2A.7020200@itee.uq.edu.au>
Date: Tue, 13 Nov 2007 14:38:02 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Xilinx TEMAC driver
References: <46A5C305.5000903@dlasys.net>
	<fa686aa40707242129p1b5f5299i44818ead5ed4d2f3@mail.gmail.com>
In-Reply-To: <fa686aa40707242129p1b5f5299i44818ead5ed4d2f3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David, GRant

Grant Likely wrote:
> On 7/24/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> 
>>    Hopefully this is not too much of a mess.

> Hooray!  Thanks for posting your work.  I'm keen to try this on my
> platform.  Comments below.
> 

[snip]

Any progress on the ll_temac driver since July?  In EDK9.2, ll_temac is 
really the only supported ethernet solution, apart from ethernet lite 
(yuck).

If there's a PPC version in a reasonable state, i'm happy to see what's 
requierd to port it across to MicroBlaze.

cheers,

John
