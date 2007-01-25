Return-Path: <m.vegni@it-systems.it>
Received: from mail.it-systems.it (net203-143-073.mclink.it [213.203.143.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7018CDE081
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:30:14 +1100 (EST)
Message-ID: <45B92155.8020808@it-systems.it>
Date: Thu, 25 Jan 2007 22:29:57 +0100
From: Massimiliano Vegni <m.vegni@it-systems.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Xserve G5 doesn't reboot or restart properly with SMU compiled in
References: <45B6BC79.5060904@it-systems.it>	
	<1169620786.18754.72.camel@localhost.localdomain>	
	<45B7E2C4.4050303@it-systems.it>
	<1169679856.24996.9.camel@localhost.localdomain>
In-Reply-To: <1169679856.24996.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, tried with defconfig for g5 and disabled lots of things there, ant
it works flawslessly... rtc too!!!
Of course I've left PREEMPT disabled, because we use this machine as a
server.

Many thanks....

Ciao.

Massimiliano Vegni


Benjamin Herrenschmidt wrote:
> Also have you tried without CONFIG_PREEMPT ? Might be a bug there...
> 
> Ben.
> 
> 
