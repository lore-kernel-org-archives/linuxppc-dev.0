Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4A9D5A99.5030101@am.sony.com>
Date: Tue, 1 Sep 2009 10:32:09 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Lee HongWoo <hongwoo7@gmail.com>
Subject: Re: Question about linux boot procedure (head_64.S)
References: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
In-Reply-To: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2009 03:58 AM, Lee HongWoo wrote:
> __start  (in head_64.S)
>   ---> __start_initialization_multiplatform (in head_64.S)
>     ---> __boot_from_prom (in head_64.S)
>        ---> prom_init ( in prom_init.c)
>          ---> __start ???
> 
> And I don't understand where __start is called, because I can find __start
> only in head_64.S.
> If it calls __start in head_64.S, it's a recursive call.
> 
> Can anybody explain about this precedure ?

In the general case, __start is the entry point of the kernel.
It is where the bootloader or boot wrapper program jumps to
when it transfers control to the kernel.

-Geoff
