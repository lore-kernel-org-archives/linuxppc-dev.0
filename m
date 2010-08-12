Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 5DB34B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 04:02:49 +1000 (EST)
Received: from [10.11.13.106] (unknown [10.11.13.106])
	by mail.theptrgroup.com (Postfix) with ESMTP id AF8611E003
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 13:53:52 -0400 (EDT)
Message-ID: <4C64352F.4090005@theptrgroup.com>
Date: Thu, 12 Aug 2010 13:53:51 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
References: <AANLkTikrpqFQsK=YLkHeWc1ZC=_Gz2rWStJrbQ8O-SrZ@mail.gmail.com>
In-Reply-To: <AANLkTikrpqFQsK=YLkHeWc1ZC=_Gz2rWStJrbQ8O-SrZ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2010 06:18 PM, Manikandan Ramachandran wrote:
> Hello All,
>      I created a very simple program which has higher priority than
> normal tasks and runs a tight loop. Under same test environment I ran
> this program on both non-rt and rt 2.6.33.5 kernel.  To my suprise I see
> that performance of non-RT kernel is better than RT. non-RT kernel took
> 3 sec and 366156 usec while RT kernel took about 3 sec and 418011
> usec.Can someone please explain why the performance of non-rt kernel is
> better than rt kernel? From the face of the test result, I feel RT has
> more overhead,Is there any configuration that I could do to bring down
> the overhead?

Your "surprise" is due to your definition of "performance".

The purpose of the -rt kernels is to reduce the kernel latency.  This is 
important for servicing hardware.  Normal users find the -rt useful for 
audio/video applications.  Engineering and scientific users find the -rt 
beneficially for servicing hardware like sensors or control systems.

If you are just trying to run calculations as fast as you can in user 
space, you'd be better off using the non-rt variants.


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
