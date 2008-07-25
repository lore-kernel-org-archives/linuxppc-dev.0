Return-Path: <timur@freescale.com>
Message-ID: <4889FD1D.4010804@freescale.com>
Date: Fri, 25 Jul 2008 11:19:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>	
	<48899736.8020400@grandegger.com>	
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com>
In-Reply-To: <4889EFFE.2070201@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:

> I know but we still need an algorithm for MPC52xx and MPC82xx as well.

That's true, but I still think hard-coding values of DFSR and FDR in the device
tree is not a good way to do this.

-- 
Timur Tabi
Linux kernel developer at Freescale
