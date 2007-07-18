Return-Path: <scottwood@freescale.com>
Message-ID: <469E3B27.6040406@freescale.com>
Date: Wed, 18 Jul 2007 11:09:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 05/61] bootwrapper: Change cuImage .gitignore entry to
	cuImage.*
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013301.GD15238@ld0162-tx32.am.freescale.net>
	<20070718014200.GB18251@localhost.localdomain>
In-Reply-To: <20070718014200.GB18251@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Jul 17, 2007 at 08:33:01PM -0500, Scott Wood wrote:
> 
>>Signed-off-by: Scott Wood <scottwood@freescale.com>
>>---
>> arch/powerpc/boot/.gitignore |    4 +---
>> 1 files changed, 1 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
>>index eec7af7..3270335 100644
>>--- a/arch/powerpc/boot/.gitignore
>>+++ b/arch/powerpc/boot/.gitignore
>>@@ -18,9 +18,7 @@ kernel-vmlinux.strip.c
>> kernel-vmlinux.strip.gz
>> mktree
>> uImage
>>-cuImage
>>-cuImage.bin.gz
>>-cuImage.elf
>>+cuImage.*
>> zImage
>> zImage.chrp
>> zImage.coff
> 
> 
> Err... your new wildcard won't match plain 'cuImage'.

When is plain "cuImage" ever generated anymore?

-Scott
