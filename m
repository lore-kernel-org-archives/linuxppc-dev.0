Return-Path: <seema.pm@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 5DEAFDE108
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 07:27:10 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so450187wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 14:27:09 -0700 (PDT)
Message-ID: <4e69a5150806181427r5acc8905u16c046492df7243c@mail.gmail.com>
Date: Wed, 18 Jun 2008 14:27:09 -0700
From: "SEEMA pm" <seema.pm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: kgdb issues for ppc target
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8152_29366162.1213824429049"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8152_29366162.1213824429049
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I have an mpc8540 target board with a BSP - linux-2.6.11. I have a host
machine where I have ppc-target configured gdb obtained from gdb-6.8.tar.gz.
I am able to debug userspace files by running gdbserver in target machine.
Now I want to debug kernel files of my target machine. I have
CONFIG_DEBUG_KERNEL=y, CONFIG_DEBUG_INFO=y and CONFIG_SERIAL_TEXT_DEBUG=y.
I want to debug kernel remotely after it's loaded in the target machine as I
do with userspace files. In the host machine when i run: gdb ./uImage, I get
not in executable format - error.

I have downloaded kernel patches : linux-2.6.13-kgdb-2.3 and applied
core-lite.patch,ppc-lite.patch and eth.patch, got lot of hunks and failed
messages. After this when I build uImage I am getting lot of build errors.

It would be really helpful if I can get the list of exact patches needed so
I can make the changes manually as mine is a modified 2.6.11 kernel. Also, I
need steps of how to run it in the target machine through ethernet port.

Thanks

------=_Part_8152_29366162.1213824429049
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I have an mpc8540 target board with a BSP - linux-2.6.11. I have a host machine where I have ppc-target configured gdb obtained from gdb-6.8.tar.gz. I am able to debug userspace files by running gdbserver in target machine.<br>
Now I want to debug kernel files of my target machine. I have CONFIG_DEBUG_KERNEL=y, CONFIG_DEBUG_INFO=y and CONFIG_SERIAL_TEXT_DEBUG=y.<br>I want to debug kernel remotely after it&#39;s loaded in the target machine as I do with userspace files. In the host machine when i run: gdb ./uImage, I get not in executable format - error.<br>
<br>I have downloaded kernel patches : linux-2.6.13-kgdb-2.3 and applied core-lite.patch,ppc-lite.patch and eth.patch, got lot of hunks and failed messages. After this when I build uImage I am getting lot of build errors.<br>
<br>It would be really helpful if I can get the list of exact patches needed so I can make the changes manually as mine is a modified 2.6.11 kernel. Also, I need steps of how to run it in the target machine through ethernet port.<br>
<br>Thanks<br><br><br><br>

------=_Part_8152_29366162.1213824429049--
