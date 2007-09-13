Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1554FDDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 03:20:58 +1000 (EST)
In-Reply-To: <1189666392244-git-send-email-galak@kernel.crashing.org>
References: <11896663903617-git-send-email-galak@kernel.crashing.org>
	<1189666391295-git-send-email-galak@kernel.crashing.org>
	<1189666392244-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9dfa95aee659e33d9fbbe2b1815ec16d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] [POWERPC] DTS cleanup
Date: Thu, 13 Sep 2007 19:20:48 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Removed the following cruft from .dts files:
> * 32-bit in cpu node -- doesn't exist in any spec and not used by 
> kernel
> * removed built-in (chrp legacy)
> * Removed #interrupt-cells in places they don't need to be set
> * Fixed ranges on lite5200*
> * Removed clock-frequency from i8259 pic node, not sure where this 
> came from
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

You also removed "big-endian" from an 8259 node, please put that
in the commit message too.


Segher
