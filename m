Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17193.22140.962651.122114@cargo.ozlabs.ibm.com>
References: <17193.22140.962651.122114@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <70CB8719-62AB-487C-8FE6-9B5242319283@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 12:28:18 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 15, 2005, at 6:09 AM, Paul Mackerras wrote:

> Jon Loeliger writes:
>
>
>> In the Grand Scheme of Things, removing things and making them
>> simpler seems a lofty goal. :-)   Anyone know of any pitfalls that
>> await me if I try to remove these sections, a la pmac and friends?
>>
>
> You'll probably get most objection from the PReP users, for whom
> getting back a few hundred kB is a big deal.  (Maybe we should just
> buy both of them a G5 or something. 8-)

If they care that much they should submit a patch to build a PReP  
specific kernel that doesn't include this stuff.  And while you are  
buying G5's for people send one my way :)

I vote that we just get ride of this sections stuff for prep, pmac,  
of, chrp and if we want to reduce the code size make it a compile  
choice to build specific kernel's that dont include the crap that the  
others need.  (especially based on the numbers that Jon has posted  
for size).

- kumar
