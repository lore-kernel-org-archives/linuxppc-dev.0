Message-ID: <004e01c1eff0$50f70500$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: =?ks_c_5601-1987?B?wPzH/b+1?= <hychon@corebell.co.kr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <001201c1efdd$301e7d80$3200a8c0@genetelhychon>
Subject: Re: looking for source files for MPC8xx --- help me~~~
Date: Tue, 30 Apr 2002 11:39:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> 1. Could you tell me how to find the sources ??
>
> and I read a following message in mailling web site ( http://lists.linuxppc.org/linuxppc-embedded/200003/msg00077.html )
> I go to the http://www.mvista.com site , but I can't anyting source
>
>
Montavista's Hardhat Linux is not available on internet any more. If you're gonna make a ramdisk or nfs root for linux root file system. I think Wolfgang denk's CDK and SELF is a good starting point. You can find them at...
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/

> 2. and I found some source for bash-xxx.tar.gz ..etc  from gnu.org
> when I complile the sources using powerpc-linux compiler  ( gcc-2.95 , glibc-2.2.3 )
> it's giving error  that
>
> checking  whetehr setvbuf argument are reserved... configure: error cannot run test program while cross compiling
>
>
> I was compiled following option
> #./configure --host=poweprc-linux --build=i386-linux
>
> what's problem?? I'm not understanding.....
>
I encountered the same error before. I don't think bash support cross compiling.
Good Luck
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
