Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 469B2B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 02:04:24 +1100 (EST)
In-Reply-To: <1259880447-5008-5-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-5-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <35292EA0-C387-4F7E-8A81-91C5CC2222FC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 4/6] powerpc: wii: hollywood interrupt controller
	support
Date: Sat, 12 Dec 2009 16:12:51 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Add support for the dual interrupt controller included in the  
> "Hollywood"
> chipset of the Nintendo Wii video game console.
> This interrupt controller serves both the Broadway processor (as a  
> cascade)
> and the Starlet processor, and is used to manage interrupts for the
> non-classic hardware.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
