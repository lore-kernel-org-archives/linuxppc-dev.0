Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id D0EC3679E8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 18:06:32 +1000 (EST)
To: Srivatsan CR <Srivatsan.CR@in.flextronics.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 01 Jun 2005 11:08:41 +0530."
	<3B58B875DBDE504F94D2A1A1C9DF6F1FD00500@bglnt005.asia.ad.flextronics.com>
Date: Wed, 01 Jun 2005 10:05:45 +0200
Sender: wd@denx.de
Message-Id: <20050601080550.C98C3C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Newbie question on Linux-PPC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3B58B875DBDE504F94D2A1A1C9DF6F1FD00500@bglnt005.asia.ad.flextronics.com> you wrote:
> I am having a MPC8260 based board with the following memory map.
>       
> Device      Start address     End address
> EPROM       0x00000000        0x03FFFFFF
> SDRAM       0x04000000        0x13FFFFFF
>  
> I have a doubt regarding Linux Port onto this board. I have read on the web
> that Linux usually expects the SDRAM at 0x0, is it that the porting of linux
> onto this board is totally impossible? If the porting is possible can anyone

No, proting is still possible, it involves just one additional  step:
fixong your boot loader to provide a different memory map.

> help me out where to change the memory mapping of Linux for MPC8260?

In your boot loader.

> ------_=_NextPart_001_01C5666C.2B0053B0
> Content-Type: text/html
> Content-Transfer-Encoding: quoted-printable
> 
> <html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =

Please don't poost HTML to mailing lists.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you hear an onion ring, answer it.
