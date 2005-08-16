Return-Path: <kjoutwater@raytheon.com>
Received: from tus-gate4.raytheon.com (tus-gate4.raytheon.com [199.46.245.233])
	by ozlabs.org (Postfix) with ESMTP id 6C05067F33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 01:49:12 +1000 (EST)
Received: from ds02t00.directory.ray.com (ds02t00.directory.ray.com
	[147.25.154.117])
	by tus-gate4.raytheon.com (8.12.10/8.12.10) with ESMTP id
	j7GFn9Lq021417 for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 08:49:10 -0700 (MST)
Received: from ds02t00 (localhost [127.0.0.1])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7GFn5Vm001048
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 Aug 2005 15:49:05 GMT
Received: from ds02t00.directory.ray.com with LMTP by ds02t00
	(2.0.6/sieved-2-0-build-559)
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 Aug 2005 15:49:05 +0000
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7GFmsrn000910
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 15:48:59 GMT
In-Reply-To: <4301C22F.2070006@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF1B6DBB03.E543CEAD-ON0725705F.0056B53A-0725705F.0056E021@mck.us.ray.com>
Date: Tue, 16 Aug 2005 08:48:54 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: Best kernel for Xilinx VirtexII Pro/PPC405 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrei - 
Just to be clear: we are talking about linuxppc-2.4 NOT 
linuxppc_2_4_devel, right?
Keith

Andrei Konovalov <akonovalov@ru.mvista.com> wrote on 08/16/2005 03:38:39 
AM:

> Keith J Outwater wrote:
> > Hello all - 
> > I am designing an embedded system using a Xilinx Virtex II Pro FPGA.
> > Can anyone point me to the "best" kernel source tree to use ?
> > "Best" in this case means:
> > 1. A 2.4 series kernel with good support for Xilinx peripheral devices 

> > (existing Xilinx ML300 support is fine).
> > 2. Good stability
> > 
> > By default I'll use the Montavista linuxppc_2.4 tree unless there is a 

> > better choice out there.
> 
> If you mean the rsync access to source.mvista.com::linuxppc-2.4
> then yes, this is the most recent (as regards to Virtex II Pro support)
> community 2.4 tree.
> 
> Thanks,
> Andrei
> 
> > Thanks!
> > 
> > Keith
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
