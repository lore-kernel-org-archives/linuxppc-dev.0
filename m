Date: Fri, 17 May 2002 09:53:18 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Lao Dingxiong <laodx@gzjpg.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How can I run linux on MOTOROLA MVME5100 ?
Message-ID: <20020517095318.C1818@ipnpcu5.in2p3.fr>
References: <20020517121100.SM00168@------>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=gb2312
In-Reply-To: <20020517121100.SM00168@------>; from laodx@gzjpg.com on ven, mai 17, 2002 at 05:46:27 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Le ven, 17 mai 2002 05:46:27, Lao Dingxiong a écrit :
>
> I have heard that the newly linux kernel(2.4, or above) can support 5100.
> So I compiled a 2.4.7 kernel, but it can't work!!!
> I want to know should I patch the kernel with a 5100 supported patch?
> if yes, where can I get this patch?
> Thanks for your help.

Where did you take your kernel sources ?
I'm using a 2.4.11 kernel from http://ppc.bitkeeper.com/

O+ xavier

PS: I have developped a driver for the vme part (highly inspired from
Gabriel Paubert one's)
with a rtlinux response for the interrupts. I have put it under GPL, but
for the moment
I don't have a ftp server to put it...
I don't have tested it with others kernels (the rtlinux part can easily be
replaced by a normal irq gestion).
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
