Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id 2BF1F2BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 10:11:34 +1000 (EST)
Received: from sonartech.com.au (daveg@dgees.sonartech.com.au [203.28.130.98])
	by sonartech.com.au (8.12.11/8.12.11) with ESMTP id i8L0DQX4020841
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 10:13:26 +1000
Message-ID: <414F71F0.9000309@sonartech.com.au>
Date: Tue, 21 Sep 2004 10:12:32 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <414916BD.9080607@sonartech.com.au>	<20040915223624.A25752@home.com>	<414946A0.1020306@sonartech.com.au>	<20040920173241.GL27914@smtp.west.cox.net>	<20040920122312.A8344@home.com>
	<414F5FED.6070107@sonartech.com.au>
In-Reply-To: <414F5FED.6070107@sonartech.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm still playing with the config, so please excuse the "weird" 
> selections in the config which is also attached, but the notable 
> differences between it and the arch/ppc/configs/mvme5100_defconfig are 
> that it has selections for a default console, and input devices ( 
> which isn't needed, I know)  and .....
>
That should of been, the config (changed from the pplus config) I 
attatched has none of the CONSOLE ... bits selected but has  
CONFIG_SERIAL_TEXT_DEBUG which you need the patch I attached 
