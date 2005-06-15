Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 6F89A67B7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 09:39:11 +1000 (EST)
To: Jaap-Jan Boor <jjboor@aimsys.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Jun 2005 22:04:46 +0200."
	<187119B8-515D-4903-AAB5-05BF80215A4D@aimsys.nl>
Date: Thu, 16 Jun 2005 01:38:45 +0200
Sender: wd@denx.de
Message-Id: <20050615233850.D7240C1510@atlas.denx.de>
Cc: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	linuxppc-embedded@ozlabs.org
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

In message <187119B8-515D-4903-AAB5-05BF80215A4D@aimsys.nl> you wrote:
> I did once ran lmbench on a proprietry 850 based board running at  
> 62/31 Mhz using 1 16-bit dram:
> 
> Context switching - times in microseconds - smaller is better
> -------------------------------------------------------------
> Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/ 
> 64K
>                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw    
> ctxsw
> --------- ------------- ----- ------ ------ ------ ------ -------  
> -------
> test    Linux 2.4.25- 259.2  234.2         302.6          304.7
> 
> This is ~ 3x faster then your 100Mhz 885...

I just ran lmbench on a MPC866 system (CPU at 132 MHz, bus at 66 MHz):

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
tqm8xx     Linux 2.4.25 5.4500   27.5   30.3   39.0   36.0    37.7    33.5


There is definitely something wrong with Peter's measurements.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.
