Message-Id: <200212231453.IAA20209@lists.linuxppc.org>
From: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: use bdi on board with ppcbug
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 23 Dec 2002 22:58:26 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi!
    Thanks a lot! I know the where the entry of ppcbug is,but by testing not regular operation.My board's ppcbug entry is 0xfff04000,is it strange?
     And another question:when I use bdi2000 to debug the kernel,if I use 'next'command, the kernel will run until the end of the kernel(that is the whole start procedure).But the normal situation should be excuting a single instruction!Can anybody tell me Why?
     Thanks in advance

>  I want to debug the kernel on the motorola lopec p011 board with bdi
>tools. And the first thing I must solve is to let the ppcbug "go" under
>the bdi control. But I don't know where the entry of ppcbug is,so I
>can't "go" the ppcbug. Has anybody know that?Or,the ppcbug can not be
>run under this circumstances?

                                                     yujing
                                                     yuj@mail.ndsc.com.cn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
