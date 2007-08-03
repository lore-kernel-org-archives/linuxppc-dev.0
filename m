Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 811CEDDE21
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Aug 2007 01:50:21 +1000 (EST)
Message-ID: <46B34F32.5050506@ru.mvista.com>
Date: Fri, 03 Aug 2007 19:52:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ssaravanan@arasor.in
Subject: Re: How can I boot powerpc kernel?
References: <380-22007853151115543@M2W019.mail2web.com>
In-Reply-To: <380-22007853151115543@M2W019.mail2web.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

ssaravanan@arasor.in wrote:

>  i am  new  to powerpc architecture.... i have a question that How i will
> boot powerpc kernel....? currently i am using MPC8555E network processor..
> using uboot and montavista kernel, using this i have tried to boot the
> kernel. After verification of images my board is hangs for ever....How can
> i solve this? Is that PowerPC required flat tree for booting linux kernel?

    Yes, you must supply the tree. If you're using U-Boot, the following 
sequence should boot you Linux:

=> tftpboot 800000 uImage
=> tftpboot e00000 mpc8555e.dtb
=> bootm 800000 - e00000

> thanks.

> Regards,
> Saravanan.S

WBR, Sergei
