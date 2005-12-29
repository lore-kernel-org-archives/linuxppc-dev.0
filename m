Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15809.mail.cnb.yahoo.com (web15809.mail.cnb.yahoo.com
	[202.165.102.89]) by ozlabs.org (Postfix) with SMTP id D661B6894D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 15:37:24 +1100 (EST)
Message-ID: <20051229043720.15530.qmail@web15809.mail.cnb.yahoo.com>
Date: Thu, 29 Dec 2005 12:37:20 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: MPC8347 USB problem : Copying big file[>150MB] discontinuous via
	Samba
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

We met a USB performance problem on a custom 8347

board with 2.4.31. When copying small files no 
more than 100MB in size, it worked smoothly with 
NEC or VIA PCI card. But copying a big file like 
more than 150MB in size would decrease the
copying
speed a lot. Serial console even couldn't
response 
'ls' command. The target has a 128MB DDR RAM.

While the same driver with 2.4.31 worked fine on
a 
8248 custom board. What could the problem be?

Sorry to distrub you during Christmas Time.

Thanks in advance,

Sam


Best regards,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
