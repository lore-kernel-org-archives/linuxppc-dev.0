Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B0D9F67BF4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 03:00:26 +1100 (EST)
Date: Thu, 2 Nov 2006 17:00:09 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Stephen Winiecki <stevewin@us.ibm.com>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
Message-ID: <20061102160009.GC4928@localhost.localdomain>
References: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
	<OF4DAC86D4.8F202745-ON8725721A.00550DB9-8525721A.00556835@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF4DAC86D4.8F202745-ON8725721A.00550DB9-8525721A.00556835@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 02, 2006 at 10:32:53AM -0500, Stephen Winiecki wrote:
> 
>    I also have a question about 750xx platforms.  I currently am looking at
>    adding platform code supporting IBM 750GX/CL eval boards.  Where would
>    they go - as well as others like Buckeye/Chestnut if/when they move over
>    to /powerpc?

I don't know - Lets wait for ben and others what they say about this
approach.
My intention with this patch is to try and motivate people to
integrate their machines as a part of the multiplatform support, because
it doesn't cost a thing.
The presence of the embedded6xx entry and the entries in the directory
itself makes people think (me too) that the multiplatform thing is only
for the big irons. I think it's better to unify the two ways of platform
support where it's possible.

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
