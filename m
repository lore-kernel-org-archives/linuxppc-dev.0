Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.62.0708240909370.19123@pademelon.sonytel.be>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
	<20070823033318.GJ7042@localhost.localdomain>
	<F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
	<20070823185632.GA3571@cynthia.pants.nu>
	<Pine.LNX.4.62.0708240909370.19123@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9185AE94-7B04-4DC7-8B9D-C92D13AC6D6F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Fri, 24 Aug 2007 02:24:19 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 24, 2007, at 2:10 AM, Geert Uytterhoeven wrote:

> On Thu, 23 Aug 2007, Brad Boyer wrote:
>> Just as an extra note, the file drivers/macintosh/adb-iop.c is  
>> m68k only,
>> so you should probably leave that alone as well. It probably  
>> doesn't need
>> that header, but the change should really come from the 68k side  
>> of things.
>
> Thanks, it's indeed not needed.

If its ok that the removal comes from my patchset that would be  
great.  I'm tired of re-spinning these patches at this point ;)

- k
