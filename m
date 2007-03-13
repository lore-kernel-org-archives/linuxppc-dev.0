Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A6DFBDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:00:40 +1100 (EST)
Message-ID: <45F6FAC5.3040504@freescale.com>
Date: Tue, 13 Mar 2007 13:25:57 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
	<20070313181617.GA5360@ld0162-tx32.am.freescale.net>
	<F7652F68-D6FF-465C-BC8F-4F0C4D976AC0@kernel.crashing.org>
	<45F6F4EE.8090504@freescale.com>
	<989DE823-E0A3-47F6-9831-A3A86FE22367@kernel.crashing.org>
In-Reply-To: <989DE823-E0A3-47F6-9831-A3A86FE22367@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I'll buy that, I forget that the dts is suppose to be board specific :)
> 
> Did this really work for 8560 and CPM based uarts?

There's no support for CPM uarts in the bootwrapper yet.  I'm tempted to 
just disable bootwrapper console I/O for such boards, as the command 
line can be changed from u-boot and passed through the bd_t.

-Scott
