Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 587E5DDDBC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 00:58:34 +1100 (EST)
Message-Id: <00F33F10-8CD0-465F-9545-46009AA85E8E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
In-Reply-To: <d2b9ccd90902120159k4f6024bbl831b43073d4126f3@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PowerPC 7447A Paging table Search
Date: Thu, 12 Feb 2009 07:58:27 -0600
References: <d2b9ccd90902120159k4f6024bbl831b43073d4126f3@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 12, 2009, at 3:59 AM, sumedh tirodkar wrote:

> How will i confirm if PowerPC 7447A processor has or does not have a
> dedicated hardware for page table search algorithm?
> If it does not have, then which interrupt handler is written for page
> address translation mechanism?

It has one and linux uses it.

- k
