Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8716267D8A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 02:39:38 +1000 (EST)
In-Reply-To: <20050727125746.54329281.akpm@osdl.org>
References: <20050727125746.54329281.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <53E238A9-96C5-444F-9620-F190560D7AF9@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 31 Jul 2005 11:39:33 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
	maintained
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Can you drop the ep405 removal patch.  We've got someone to take  
ownership.

- kumar

On Jul 27, 2005, at 2:57 PM, Andrew Morton wrote:

> Kumar Gala <galak@freescale.com> wrote:
>
>>
>> The following board ports are no longer maintained or have become
>>  obsolete:
>>
>>  adir
>>  ash
>>  beech
>>  cedar
>>  ep405
>>  k2
>>  mcpn765
>>  menf1
>>  oak
>>  pcore
>>  rainier
>>  redwood
>>  sm850
>>  spd823ts
>>
>>  We are there for removing support for them.
>>
>
> I'll merge all these into -mm for now, but will hold off sending  
> any of
> them upstream pending confirmation of which patches we really want to
> proceed with.
>
