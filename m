Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E052CDDE21
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 07:25:21 +1100 (EST)
In-Reply-To: <45A1535C.1080007@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
Date: Sun, 7 Jan 2007 21:24:58 +0100
To: Matt Sealey <matt@genesi-usa.com>
Cc: David Woodhouse <dwmw2@infradead.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>, Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> (especially a C-based one, OpenBIOS
> is 90% Forth which is a terrible lock-in)

> Isn't the e300 PVR and e300 SVR, or any other device identifier on the
> chip, a much better differentiator for drivers, than a named 
> compatibility
> flag?

Only 7 days into the new year, and already we get some great
entries for best-joke-of-2007!  Too bad they're factually
incorrect.


Segher
