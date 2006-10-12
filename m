Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA0C167BBD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 20:34:10 +1000 (EST)
Message-ID: <452E1A1D.1050601@genesi-usa.com>
Date: Thu, 12 Oct 2006 12:34:05 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ganesh subramonian <gun_raj@yahoo.com>
Subject: Re: Handling machine check exception
References: <20061012045943.9389.qmail@web52403.mail.yahoo.com>
In-Reply-To: <20061012045943.9389.qmail@web52403.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The G2 core definitely has a DAR register (SPR 19).

Look on the Freescale site for G2CORERM.pdf - this is
your reference manual, not the one specifically for the
8247.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

ganesh subramonian wrote:
> Hi,
> 
> I am trying to modify the machinecheck exception
> handler so that checks caused by data access to a
> particular address range can be ignored. In mpc866
> there is a register called DAR(Data Address Register)
> which gives the address[access to] which caused the
> exception. However this is not mentioned in the
> MPC8247 manual. Is there some equivalent register for
> 8247. (It seemed to me that the DAR should be a core
> register and hence should be there on 8247 also. but
> if i try to read i really dont get the address causing
> the error).
> 
> Or is there some way i can specify that access to a
> particular range of address should not cause a machine
> check?? Please help.
> 
> thanks
> ganesh
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
