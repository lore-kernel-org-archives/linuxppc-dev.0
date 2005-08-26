Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050826191450.GB6265@austin.ibm.com>
References: <20050826191450.GB6265@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <31AB6D4D-58E8-4BB6-9191-2C0710397D69@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 26 Aug 2005 14:23:43 -0500
To: Olof Johansson <olof@lixom.net>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: Add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 26, 2005, at 2:14 PM, Olof Johansson wrote:

> On Fri, Aug 26, 2005 at 02:07:37PM -0500, Kumar Gala wrote:
>
>> What were you building for?  I'm wondering if the same issue exists
>> that you are asked, but its not wired to actually do anything.
>>
>
> Doh, you're right. No, it's not wired up. I was building for pmac.

Ok, sent a patch to linuxppc-dev for ppc32 which mimic's Anton's  
patch.  Once we get an include/asm-powerpc going we can merge these  
into on file that lives there.

- kumar
