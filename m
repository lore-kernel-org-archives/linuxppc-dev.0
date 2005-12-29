Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id 6456768910
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 23:54:07 +1100 (EST)
Message-ID: <20051229125405.18967.qmail@web15805.mail.cnb.yahoo.com>
Date: Thu, 29 Dec 2005 20:54:05 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20051229043720.15530.qmail@web15809.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Re : MPC8347 USB problem : Copying big file[>150MB] discontinuous
	via Samba
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song <samlinuxppc@yahoo.com.cn> wrote:
> Hi all,
> 
> We met a USB performance problem on a custom
> 8347board with 2.4.31. When copying small 
> files no more than 100MB in size, it worked 
> smoothly with NEC or VIA PCI card. But 
> copying a big file like more than 150MB 
> in size would decrease the copying
> speed a lot. Serial console even couldn't
> response 'ls' command. The target has a 
> 128MB DDR RAM.

Ummm, actually, 256MB DDR RAM.

> While the same driver with 2.4.31 worked fine
> on a 8248 custom board. What could the 
> problem be?

Arhhhh, it was due to USB 1.1 limitation
itself(8347 USB 2.0 driver wasn't added 
yet when I posted it). Only on the 
workable 8248 target with USB 1.1 driver, 
it would have such a phenomena. There was 
even a network error displayed. If working
with USB 2.0, no any problem. New to me:-)

But Well, I don't have the guts
to say this is a kernel's bug:-)

> Sorry to distrub you during Christmas Time.

OK, stay on relax, pls.

Best regards,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
