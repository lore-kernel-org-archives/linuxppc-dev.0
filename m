Message-Id: <3879B10F.D6C21C0F@ict.ac.cn>
Date: Mon, 10 Jan 2000 18:14:39 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ;X84: problem with gunzip()
References: <003001bf5b47$6aeebe20$73f102de@sjzhu>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



You mean the extenal interrupt enable bit?
It's really disabled before gunzip.

LiuTao

Shuangjun Zhu wrote:
> 
> Before you gunzip the kernel, clear the interrupt bit in the
> machine status register.
> 
> -----Original Message-----
> From: LiuTao <tliu@ict.ac.cn>
> To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>; linuxppc-embedded@lists.linuxppc.org
> <linuxppc-embedded@lists.linuxppc.org>
> Date: Monday, January 10, 2000 4:43 PM
> Subject: problem with gunzip()
> 
> >
> >Hi
> >
> >When I ported linux to a board with MPC860, 16M RAM and 2M Flash,
> >I met a problem.
> >After the program gunzip()(misc.c) the vmlinux image to address 0x0,
> >the contents from 0x0 to IMAGE_SIZE should be as same as that in
> >linux/vmlinux, right? I found that they are not same. Only from 0x0
> >to about 0xb500, they are same.
> >I don't think gunzip() has any problem.
> >Do you have any suggestions?
> >Thanks!
> >
> >LiuTao
> >

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
