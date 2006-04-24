Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 08A2267A44
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 08:06:02 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Clock running fast on Mac Mini?
Date: Mon, 24 Apr 2006 17:06:00 -0500
References: <E1FY8kd-0000mH-PO@owl.grunz.lu>
In-Reply-To: <E1FY8kd-0000mH-PO@owl.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604241706.00623.bcook@bpointsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 24 April 2006 16:37, Mich Lanners wrote:
> Hello all,
>
> I have a problem on my Mac Mini with the kernel clock, which is running
> fast.
>
> In fact, it is gaining 10 ms every 5 seconds, as can be seen here, with
> ntpdate called every 5 seconds:
>

I can confirm this. I can also trigger make's 'File has future modification 
date' warning message when compiling a file on the local filesystem.

 - Brent
