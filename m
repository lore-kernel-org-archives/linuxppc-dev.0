Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1FCBF67A78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 02:30:12 +1100 (EST)
In-Reply-To: <1111395923.14412.23.camel@felix.allot.com>
References: <1111395923.14412.23.camel@felix.allot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fce4e1652b6f0eb3c1b3d28e4958c262@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 09:30:10 -0600
To: "Felix Radensky" <felix@allot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: New PowerQUICC III support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Felix,

The expectation is that the existing gianfar driver should work on 
8548.  However until its tried out we will not know for sure.

- kumar

On Mar 21, 2005, at 3:05 AM, Felix Radensky wrote:

>  Hi, Kumar
>
>  Thanks for answering. There isn't much info regarding new PQ3 chips on
>  Freescale site, so It's hard to tell how similar they are to 
> 8540/8560.
>  I'm interested in basic support and Gigabit ethernet driver. Are you 
> saying
>  that gianfar driver will work with new PQ3 chips ?
>
>  Thanks a lot.
>
>  Felix.
>
>  On Sun, 2005-03-20 at 12:43 -0600, Kumar Gala wrote:
>
>  Felix,
>
>  Is there something specific about the new PQ3 chips you are looking
>  for?  The basic support that is in the kernel for the existing PQ3 
> line
>  (8540, 8541, 8555, 8560) should work on these devices w/o much change.
>
>  - kumar
>
>  On Mar 20, 2005, at 4:09 AM, Felix Radensky wrote:
>
>  >  Hi, folks
>  >
>  >  Are there any plans to support new PowerQUICC III models (e.g. 
> 8543,
>  > 8548)
>  >  in the near future ? Is anyone working on it ?
>  >
>  >  TIA.
>  >
>  >  Felix. <ATT325611.txt>
>
>
