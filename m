Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0DE40DDFAF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 02:10:11 +1000 (EST)
In-Reply-To: <1178549765.2990.67.camel@zod.rchland.ibm.com>
References: <1178549324.2990.52.camel@zod.rchland.ibm.com>
	<1178549765.2990.67.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4d59b4ee7d3eef466bd3c25d0a71b1dc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 6/7] Holly DTS
Date: Mon, 7 May 2007 18:08:52 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Add Holly DTS file
>
> Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Looks good.  Two more non-essential things:

- Did you forget the L2 cache node or do you really
   just not care about it?
- You can put an "interrupt-parent" property in the
   host bridge node instead of in all its (indirect)
   children.


Segher
