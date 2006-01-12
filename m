Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 42837689C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 04:33:09 +1100 (EST)
Message-ID: <43C691F1.2010409@ru.mvista.com>
Date: Thu, 12 Jan 2006 20:29:21 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca
References: <11367955811900-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11367955811900-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 08/10] ML300 & ML403 need embed_config.o linked in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

grant.likely@secretlab.ca wrote:
> Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>
> 
> ---
> 
>  arch/ppc/boot/simple/Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> a39144d5708c207f58964000baf56fa9cfb18628
> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
> index f3e9c53..7abd772 100644
> --- a/arch/ppc/boot/simple/Makefile
> +++ b/arch/ppc/boot/simple/Makefile
> @@ -188,6 +188,8 @@ OBJCOPY_ARGS			:= -O elf32-powerpc
>  boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
>  boot-$(CONFIG_REDWOOD_5)	+= embed_config.o
>  boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
> +boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
> +boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
>  boot-$(CONFIG_8xx)		+= embed_config.o
>  boot-$(CONFIG_8260)		+= embed_config.o
>  boot-$(CONFIG_BSEIP)		+= iic.o

Tested OK on ML300.
