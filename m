Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AC49C61.D3B65EDE@snmc.com>
Date: Fri, 30 Mar 2001 08:46:57 -0600
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: simitel0299 <simitel0299@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where get the Linux Init Source for 8xx
References: <20010330062136.3295.qmail@sina.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wtao,

You can also find CPU PWRUP code for the MPC850 in the QSLinux release,
downloadable from ftp://qslinux.org.  It contains code to "kick" the
watchdog as it decompresses the kernel.  It also provides a very
flexible scheme for configuring processor clock speed, console port
setup, etc.  Documentation can be found at http://qslinux.org.

Regards,
Daris Nevil
SNMC


simitel0299 wrote:
>
> Hello, all:
>     Would you like to provide me with the source codes of LinuxPPC initialization for MPC8xx, just from the CPU PWRUP Reset to the OS and finally to the Application ? If available, the corresponding documents will be OK!
>     Thank you for your help!
>     Best Regards!
>                                   Wtao
>                      2001/3/30
>
> ______________________________________
>
> ===================================================================
> 新浪免费电子邮箱 (http://mail.sina.com.cn)
> 网里寻她千百度!没有"聊友速配",怎能"成双成对"? (http://newchat.sina.com.cn)
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
