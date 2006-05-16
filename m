Return-Path: <greg.weeks@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id CF3D1679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 04:33:23 +1000 (EST)
Message-ID: <446A1562.70207@timesys.com>
Date: Tue, 16 May 2006 14:09:38 -0400
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: pito50@hotmail.com
Subject: Re: Unable to boot a kernel on a MPC8560
References: <BAY105-F10857BC9DB3B958AC19C8D8EA00@phx.gbl>
In-Reply-To: <BAY105-F10857BC9DB3B958AC19C8D8EA00@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

CORVELLER Mickael wrote:
> Hello,
>
> first of all, I am a newbie in embedded linux systems.
>
> I'm trying to boot a board based on a MPC8560 (with a e500 core).
>
> I'm using a RS232 console via a debug module connected to the SCC1 port of 
> the 8560.
>
> The boot loader is U-Boot.
>
>   
What version of u-boot do you have? At some point I had a u-boot with 
the value of CCSRBAR set different from what the current kernels use. It 
caused a failure like this.

Greg Weeks
