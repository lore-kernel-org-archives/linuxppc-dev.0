Return-Path: <galak@kernel.crashing.org>
Message-Id: <EB183C40-A46E-4899-9BFF-A6D79C641AE4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200804250826.12128.jk@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] spufs: add .gitignore for spu_save_dump.h &
	spu_restore_dump.h
Date: Thu, 24 Apr 2008 19:47:19 -0500
References: <Pine.LNX.4.64.0804241136310.22265@blarg.am.freescale.net>
	<200804250826.12128.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2008, at 5:26 PM, Jeremy Kerr wrote:
> Kumar,
>
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/cell/spufs/.gitignore
>> @@ -0,0 +1,2 @@
>> +spu_save_dump.h
>> +spu_restore_dump.h
>
> nak - these still need to be tracked (and distributed with the  
> tree), as
> we want to be able to build the kernel without spu-gcc.

So they should be added to the tree?

- k
