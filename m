Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116]) by ozlabs.org (Postfix) with ESMTP id 2373A67A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 19:02:20 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j29828Ht018439
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Mar 2005 09:02:09 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <422EAD7E.5090309@246tNt.com>
Date: Wed, 09 Mar 2005 09:02:06 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Stephen Warren <SWarren@nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B0056A92CC@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0056A92CC@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 kernel with IDE *and* FEC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Warren wrote:

>From: Dale Farnsworth [mailto:dale@farnsworth.org] 
>  
>
>>On Tue, Mar 08, 2005 at 05:34:20PM +0000, Stephen Warren wrote:
>>    
>>
>>>I looked at the 2.6.11 kernel.org kernel, and it has MPC5200 IDE
>>>support, but apparently no FEC driver support.
>>>      
>>>
>>Are you sure it has MPC5200 IDE support?  I have yet to see reliable
>>5200 IDE support and haven't seen a 5200 IDE driver for 2.6 at all.
>>    
>>
>
>Not sure, no. Looking at "xconfig", I don't see an option for it. A
>colleague said it did.
>  
>
No it doesn't. Or it's very well hidden ;)
But If you do write it, patches are welcomed.

>We've used IDE (for a DVD-ROM) using the Denx kernel. This didn't have
>DMA suppport, but Freescale gave us a derivate kernel that it, which
>seemed to work well. They said they were going to push this up through
>Denx into the main kernel. Didn't they bother to do this?
>  
>
I guess they mean push it to Denx kernel which IS the main 2.4 kernel 
for MPC5200.
No new platform support will be accepted for 2.4 now. And freescale probably
won't write driver for the tree I maintain since I'm not using the 
official BestComm API.


    Sylvain
