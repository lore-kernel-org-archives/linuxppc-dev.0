Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5CE8967A33
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:36:22 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 14:59:15 CDT."
	<7BC50BA2-D657-4907-94AA-DB5926F22504@kernel.crashing.org>
Date: Thu, 27 Apr 2006 23:36:20 +0200
Sender: wd@denx.de
Message-Id: <20060427213620.A95C2353A57@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <7BC50BA2-D657-4907-94AA-DB5926F22504@kernel.crashing.org> you wrote:
>
> > NEW:	bootm <kernel_addr> - <dts_addr>
> >    or	bootm <kernel_addr> <ramdisk_addr> <dts_addr>
> 
> do you mean a literal '-' char for the no ramdisk, but dts case?

Yes. We could write "bootm <kernel_addr> NULL <dts_addr>"  or  "bootm
<kernel_addr> none <dts_addr>" or anythingl ike that as well, but I'm
a lazy typist :-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...this does not mean that some of us should not want, in  a  rather
dispassionate sort of way, to put a bullet through csh's head."
                   - Larry Wall in <1992Aug6.221512.5963@netlabs.com>
