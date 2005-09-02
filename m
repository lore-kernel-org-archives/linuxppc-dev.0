Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509020518.32732.arnd@arndb.de>
References: <200509020518.32732.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6241EC1-429C-4286-BCF0-E0D3DC5049BF@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 2 Sep 2005 08:38:39 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 1, 2005, at 10:18 PM, Arnd Bergmann wrote:

> On Dunnersdag 01 September 2005 22:51, Jon Loeliger wrote:
>
>> +/*
>> + * This file is included by 'init/main.c' to check for
>> + * architecture-dependent bugs.
>> + */
>> +
>> +extern void check_bugs(void);
>> +
>>
>
> Actually, I think this could to be
>
> +static inline void check_bugs(void)
> +{
> +}
>
> The function is empty on both ppc and ppc64, so we can just as
> well get rid of the symbol as well.
> The rest of the patch looks perfect to me.

We just have to make sure to get ride of the implementation in arch/ 
ppc*/kernel/syscalls.c if we do this.

- kumar
