Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7620167CED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 01:02:37 +1000 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k9KF2Yi15117
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 Oct 2006 20:02:34 +0500
Date: Fri, 20 Oct 2006 19:03:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 (MPC8260) SMC problem. Please help.
Message-ID: <20061020190308.28dfaf34@vitb.ru.mvista.com>
In-Reply-To: <4536913F.8060801@fabiotec.com>
References: <4536913F.8060801@fabiotec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 18 Oct 2006 22:40:31 +0200
Boris Shteinbock <boris@fabiotec.com> wrote:

> Hi ppl.
> 
> I have discovered very very odd problem with SMC2 on my 8260 board.
> kernel version is 2.6.17.
> 
> The board is 8260 with serial ports on SMC1 and SMC 2 (SMC1 - console)
> 
> Now if I use SMC2 for communicating with remote device, ( some protocol)
> I am sending packets and wait for a response.
> However if the packet I send is SMALLER than 5 bytes, SMC goes 
> completely crazy.
> write() doesn't return error, but the next read() hangs completely, and the
> process moves to D state and it is impossible to kill it by any means.
> It only happens when consequent writes of smaller than 5 bytes.
> I tried to check the driver, but couldn't find any clues to what goes wrong.
> 
> I tried both compatibility and platform-based modes with the same results.
> 
> Any help on the issue would be highliy appreciated.
> 
> 

I think that should be walked along the cpm_uart driver, TX part to see is sending stuff 
do not indicate any error in the CPM registers, or at least discover exact track leading to the endless loop. 

-- 
Sincerely, 
Vitaly
