Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id B6900DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 19:54:21 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so337588rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Aug 2008 02:54:20 -0700 (PDT)
Message-ID: <319b0ac50808070254x27606b48sb15fb4ee6105c6c6@mail.gmail.com>
Date: Thu, 7 Aug 2008 11:54:20 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Powerpc and ioremap
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11546_7980273.1218102860249"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_11546_7980273.1218102860249
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to port linux on my Powerpc Board. I have used Linux 2.6.26 and
gcc 3.4.5.
I have used Uboot 1.2.
Linux seems running from _start to udbg_early_init(). That's why I
develloped a udbg_driver.
It must write in a register which is located at 0x2001b044. So I wrote :

void __iomem *p;
p=ioremap(0x2001b044,4);
iowrite32('O',p);
iowrite32('K',p);

But when he exectuted ioremap, he looped in the __delay function.

Can you help me to solve this probleme ?

------=_Part_11546_7980273.1218102860249
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I am trying to port linux on my Powerpc Board. I have used Linux 2.6.26 and gcc <a href="http://3.4.5.">3.4.5.</a><br>
I have used Uboot 1.2.<br>
Linux seems running from _start to udbg_early_init(). That&#39;s why I develloped a udbg_driver.<br>
It must write in a register which is located at 0x2001b044. So I wrote :<br>
<br>
void __iomem *p;<br>
p=ioremap(0x2001b044,4);<br>
iowrite32(&#39;O&#39;,p);<br>
iowrite32(&#39;K&#39;,p);<br>
<br>
But when he exectuted ioremap, he looped in the __delay function.<br>
<br>
Can you help me to solve this probleme ?<br>
<br>

------=_Part_11546_7980273.1218102860249--
