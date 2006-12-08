Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 290F867B92
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 05:01:35 +1100 (EST)
Message-ID: <4579A76A.7020801@freescale.com>
Date: Fri, 08 Dec 2006 11:56:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: Document device nodes for I2C devices.
References: <20061207173353.GD22989@ld0162-tx32.am.freescale.net>
	<161D7B81-B884-4C75-B42E-1627CA538918@kernel.crashing.org>
In-Reply-To: <161D7B81-B884-4C75-B42E-1627CA538918@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Dec 7, 2006, at 11:33 AM, Scott Wood wrote:
>> +    - reg : I2C address for the device
> 
> 
> Is this a 7-bit or 8-bit padded address?

It's a 7-bit address.

-Scott
