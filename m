From: linuxppc_em@sina.com
Message-ID: <001501bfaa04$6b5cd3e0$8e21fea9@p2kasvr>
Reply-To: <linuxppc_em@sina.com>
To: "kim sook young" <icekim@sec.samsung.co.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001901bfa9a9$2a7c0040$efc5dba8@sec.samsung.co.kr>
Subject: Re: Error: Building glibc
Date: Wed, 19 Apr 2000 21:36:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "kim sook young" <icekim@sec.samsung.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, April 19, 2000 10:44 AM
Subject: Error: Building glibc


>
> Hi, all
> While building glibc, I got an error like the following
.. cut
> to build glibc. ( Actually  in order to install Binutils, Gcc and LibC, I followed the instructions only

>except for  building linux/ppc kernel )
    ^^^^^ maybe here is,   you neendn't build kernel, but you must config it,
to build  glibc,  require some head files in kernel S/T,  especially some types defines. ;)

john zhan.
b.r.
hacking time.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
