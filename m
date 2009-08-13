Return-Path: <Paul.Gortmaker@windriver.com>
Message-ID: <4A84716A.90907@windriver.com>
Date: Thu, 13 Aug 2009 16:02:50 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: derive COMMAND_LINE_SIZE from asm-generic
References: <1250192224-22772-1-git-send-email-paul.gortmaker@windriver.com>
	<200908131948.48103.arnd@arndb.de>
In-Reply-To: <200908131948.48103.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 13 August 2009 19:37:04 Paul Gortmaker wrote:
>> The default COMMAND_LINE_SIZE in asm-generic is 512, so the
>> net effect of this change is nil, aside from the cleanup
>> factor.  See also commit 2b74b8569.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Just to clarify why this is good: There is a patch from Remis
> to kbuild that can automatically create the trivial wrappers,
> so we can remove arch/powerpc/include/asm/setup.h from the
> kernel once that patch is applied.
> 
> I was also planning to submit a series to clean up more powerpc
> in this way headers where applicable, see
> http://git.kernel.org/?p=linux/kernel/git/arnd/asm-generic.git;a=shortlog;h=powerpc

I'd looked at master and next in your tree; I didn't
list all the branches and so I'd not noticed powerpc in there
as well.

> 
> The series needs some forward porting to 2.6.31 as well as testing.
> If you or someone else wants to help with that, please go ahead!

I'll definitely have a look at what is in there.

Paul.

> 
> Thanks,
> 
> 	Arnd <><
