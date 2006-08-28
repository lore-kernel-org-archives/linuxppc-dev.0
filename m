Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id 7607467A3E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 14:10:36 +1000 (EST)
Subject: Re: PCI driver
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <1156695850.6010.70.camel@mindpipe>
References: <1156695850.6010.70.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 00:10:43 -0400
Message-Id: <1156738244.6010.116.camel@mindpipe>
Mime-Version: 1.0
Cc: Leonid <Leonid@a-k-a.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 2006-08-27 at 12:24 -0400, Lee Revell wrote:
> Hello,
> 
> We have implemented a driver for a PCI sound card and are attempting to
> use it on a PPC400 Yosemite board.  However, as soon as any port I/O is
> attempted, we get a machine check error:
> 

Found the problem:

http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021708.html

Thanks!

Lee
