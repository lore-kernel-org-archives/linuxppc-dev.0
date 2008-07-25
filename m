Return-Path: <wg@grandegger.com>
Message-ID: <4889EFFE.2070201@grandegger.com>
Date: Fri, 25 Jul 2008 17:23:42 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>	
	<48899736.8020400@grandegger.com>	
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
In-Reply-To: <ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Fri, Jul 25, 2008 at 8:12 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 
>> Yes, please use something like clock-frequency or current-speed and do
>> the calculation.
> 
> Ditto.  I already wrote the code that does that for U-Boot, so all you
> need to do is port it.

I know but we still need an algorithm for MPC52xx and MPC82xx as well.

> Although I'm curious, if U-Boot already programs the speed, why does
> the driver program it again?

Maybe because it's not obvious for the driver if the registers have 
already been configured by the boot-loader.

Wolfgang.
