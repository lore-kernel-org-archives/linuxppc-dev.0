Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id C92B868847
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 19:30:16 +1100 (EST)
Received: from mx3.mail.sohu.com (unknown [192.168.95.78])
	by sogoumx75.mail.sogou.com (Postfix) with ESMTP id D75A70ED3FE5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 16:30:08 +0800 (CST)
Message-ID: <15152217.1133338686341.JavaMail.postfix@mx3.mail.sohu.com>
Date: Wed, 30 Nov 2005 16:18:06 +0800 (CST)
From: <zengshuai@sogou.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: linuxppc-embedded help needed:kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i writed a led driver for PQ2FADS(a ppc board).
but i can't read/write 0x04500000 where led register addr locate in.
i tested two ways to do that.
first,
p=0x04500000;
*p=0x12;
....
second,
outb(0x12,0x04500000);
...
two ways both didn't work.they had a some wrong:kernel access of bad area.
how can i know which area is bad area or good area?
and what can i do next? thanks.

------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
