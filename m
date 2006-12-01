Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2A06E67DCD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Dec 2006 04:00:42 +1100 (EST)
Date: Fri, 1 Dec 2006 20:00:40 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: fs_enet driver "generating" bad interrupts on 2.6.19
Message-ID: <20061201200040.090f185c@vitb.ru.mvista.com>
In-Reply-To: <200612011418.26201.laurent.pinchart@tbox.biz>
References: <200612011418.26201.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 1 Dec 2006 14:18:26 +0100
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi everybody,
> 
> I upgraded to 2.6.19 today, and found a strange issue that seems to be related 
> with the fs_enet driver on a MPC8248.
> 
> The number of "bad" interrupts, as reported by /proc/interrupts, seems to 
> grown with the number of packets received and sent by the FCC ethernet 
> controllers.
> 
I'll check if it is true on our 82xx board && FCC.


-- 
Sincerely, 
Vitaly
