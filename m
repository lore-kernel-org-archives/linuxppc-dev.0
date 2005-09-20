Return-Path: <jacmet@sunsite.dk>
Received: from adicia.telenet-ops.be (adicia.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id B638268308
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 05:49:48 +1000 (EST)
To: glikely@gmail.com
References: <528646bc05091000377417dc16@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 20 Sep 2005 21:50:35 +0200
In-Reply-To: <528646bc05091000377417dc16@mail.gmail.com> (Grant Likely's
	message of "Sat, 10 Sep 2005 01:37:39 -0600")
Message-ID: <87vf0vselw.fsf@p4.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/2] Add support for MEMEC 2VP30-FF1152 eval board with
 simple FPGA design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <glikely@gmail.com> writes:

Hi,

 Grant> Here is an example port to another V2PRO based board.  This
 Grant> patch is for information only and is NOT suitable for
 Grant> submission up to mainline

Ok, I still have a little comment though..

 Grant> diff --git a/arch/ppc/boot/simple/embed_config.c
 Grant> b/arch/ppc/boot/simple/embed_config.c
 Grant> --- a/arch/ppc/boot/simple/embed_config.c
 Grant> +++ b/arch/ppc/boot/simple/embed_config.c
 Grant> @@ -745,7 +745,7 @@ embed_config(bd_t **bdp)
 Grant>  }
 Grant>  #endif /* WILLOW */
 Grant>  
 Grant> -#ifdef CONFIG_XILINX_ML300
 Grant> +#ifdef CONFIG_VIRTEX_II_PRO
 Grant>  void
 Grant>  embed_config(bd_t ** bdp)
 Grant>  {

Please don't force all V2P boards to use the same embed_config. I'm
using RedBoot on a V2P board, which provides a ready to go bd_t that I
can directly use.

-- 
Bye, Peter Korsgaard
