Message-ID: <025c01c3d671$a30702a0$21589edd@CHKIMVAIO>
From: =?ks_c_5601-1987?B?sejEociv?= <willy@airpoint.co.kr>
To: "Q-ha Park" <qha@infoeq.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <00b901c3d669$874545c0$2a21a8c0@qha>
Subject: Re: socket programming without RTnet.
Date: Fri, 9 Jan 2004 14:30:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks your comments.

What I want is to make some network applications just as I did with vxWorks. A 'network application' means using socket/bind/sendto/recvfrom etc APIs to send and receive data to/from outside of me or between internal tasks.

I can't figure out what kernel space' and 'userland' mean. Well I am strange with embedded linux on ppc860 because I stayed with other RTOSs such as vxWorks and Nuclues. Would you explain more in detail?

Currently I patched my kernel 2.4.20 with RTAI and loaded RTAI modules after booting. Also I loaded my 'network application' using insmod.

I still wonder why there is not any standard socket APIs in the linux ppc-embedded kernel and why I can't use sys_socket/sys_bind/sys_recvfrom/sys_sendto in net/socket.c in loadable application.

Thanks.

----- Original Message -----
From: "Q-ha Park" <qha@infoeq.com>
To: "'±èÄ¡È¯'" <willy@airpoint.co.kr>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, January 09, 2004 1:31 PM
Subject: RE: socket programming without RTnet.


>
> > If I can't use those APIs, is there any good way to make a
> > socket programming without the help of RTnet?
>
> hmmm, I'm not so sure what your intention is, but why are you trying to
> play around in kernel space instead of userland if the plain network
> program is what you want?
>
> Q-ha Park
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
