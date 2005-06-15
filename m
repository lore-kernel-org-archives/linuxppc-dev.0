Return-Path: <jjboor@aimsys.nl>
Received: from smtp08.wanadoo.nl (smtp08.wanadoo.nl [194.134.35.149])
	by ozlabs.org (Postfix) with ESMTP id CD5D167B55
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 06:04:53 +1000 (EST)
In-Reply-To: <8E342283C2100540AAC5D1030970547766F7A1@rcexc.racoms.loc>
References: <8E342283C2100540AAC5D1030970547766F7A1@rcexc.racoms.loc>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <187119B8-515D-4903-AAB5-05BF80215A4D@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Wed, 15 Jun 2005 22:04:46 +0200
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I did once ran lmbench on a proprietry 850 based board running at  
62/31 Mhz
using 1 16-bit dram:

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/ 
64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw    
ctxsw
--------- ------------- ----- ------ ------ ------ ------ -------  
-------
test    Linux 2.4.25- 259.2  234.2         302.6          304.7

This is ~ 3x faster then your 100Mhz 885...

Jaap-Jan

On 15-jun-2005, at 16:55, Schaefer-Hutter, Peter wrote:



> Hi all,
>
> i'm evaluating IPC on the MPC885ADS and discovered
> that the context switching times seem to be quite
> disappointing (up to 1ms). As we need to do a lot
> of IPC later on, i'm interested bringing the time
> down.
>
> Therefore i wonder, if there are any known problems
> with the MMU on 8xx and 2.4.2x which might explain
> that?
>
> Or is this the expected context switching time for
> CPU @ 100 MHz (RAM @ 50 MHz)? Suggestions for a
> benchmark program?
>
> Thanks!
>
>   Peter
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>

____
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
