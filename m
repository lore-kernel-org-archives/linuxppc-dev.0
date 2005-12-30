Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2FF9268963
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 19:10:51 +1100 (EST)
To: "siman" <siman@bsysjob.sharella.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Dec 2005 10:26:26 +0800."
	<001301c60ce8$7b4456a0$1200a8c0@xbh>
Date: Fri, 30 Dec 2005 09:10:49 +0100
Sender: wd@denx.de
Message-Id: <20051230081049.2C117352ADF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Migrate vxworks bsp to linux 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <001301c60ce8$7b4456a0$1200a8c0@xbh> you wrote:
>
> I have the prpmc610 borad(with MPC8245), I have the board's vxworks bsp, did
> anybody have experience to migrate  from the vxworks to Linux system? I
> think the main problem is initial the boards. 

You start porting a boot loader, like U-Boot.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As far as the laws of mathematics refer  to  reality,  they  are  not
certain;  and  as  far  as  they  are  certain,  they do not refer to
reality.                                           -- Albert Einstein
