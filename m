Return-Path: <Hans.Schillstrom@lgpallgon.com>
Received: from aseit003.allgon.net (mail.lgpallgon.com [193.235.198.4])
	by ozlabs.org (Postfix) with ESMTP id 2A7D367A45
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 18:18:26 +1100 (EST)
From: Hans Schillstrom <hans.schillstrom@pwav.com>
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
In-Reply-To: <4201BAA1.3010002@rftechnology.com.au>
References: <4201BAA1.3010002@rftechnology.com.au>
Content-Type: text/plain
Message-Id: <1107415042.7900.1870.camel@hawk.allgon.net>
Mime-Version: 1.0
Date: Thu, 03 Feb 2005 08:17:23 +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: U-Boot support for MPC8270
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I have a custom board with mpc8270vr runing uboot 1.1.2 and it works
without any problem. If you follow Denx instructions it's very easy to
get it runing.
Right now Linux 2.6.10 is runing on the board.

The only problem with the MPC8270 we had was that VCORE has to be 1.7V
not 1.5V , 
/Hans 
On Thu, 2005-02-03 at 06:46, Dmytro Bablinyuk wrote:
> At what stage right now support for MPC8270 in U-Boot.
> Based on this we are thinking whether buy or not eval board, or try to 
> get system running already on a target.
> Can anybody suggest.
> 
> Thank you
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
