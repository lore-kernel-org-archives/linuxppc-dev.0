Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4540A4EF.5030802@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
	<528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
	<1161817576.22582.142.camel@localhost.localdomain>
	<4540A4EF.5030802@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 22:51:40 +1000
Message-Id: <1161867101.25682.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-26 at 14:09 +0200, Nicolas DET wrote:

> What do you mean exactly by 'the IPB freq should be in the device-tree'? 
> It is as property.

Yeah, just that drivers should pick it up from there

Ben.
