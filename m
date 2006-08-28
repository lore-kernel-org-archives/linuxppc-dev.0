Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0D409679FB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 00:50:24 +1000 (EST)
Date: Mon, 28 Aug 2006 18:50:22 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Subject: Re: uart_cpm scc Rx problem after second open of the device
Message-ID: <20060828185022.51e98fc4@vitb.ru.mvista.com>
In-Reply-To: <op.tezypejhnhx3hy@draco>
References: <op.tezypejhnhx3hy@draco>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Aug 2006 17:04:16 +0300
"Alexandros Kostopoulos" <akostop@inaccessnetworks.com> wrote:

> I experienced a problem with the cpm_uart scc driver (kernel version  
> 2.6.13) while running the driver for a serial port NOT configured as a  
> console.
> The problem is as follows:
> The first time the device (/dev/ttyCPM0) is opened, everything works ok.  
> The second time, however, the device is opened, receive does not work. The  
> device can only transmit, but doesn't receive anything.
> 
I'm recalling to fix it a while ago (later than .14 though). There were not just the line below,
but you cant find the respective stuff on the line (linuxppc-embedded) archive/ kernel git.



-- 
Sincerely, 
Vitaly
