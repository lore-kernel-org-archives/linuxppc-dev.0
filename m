From: "Q-ha Park" <qha@infoeq.com>
To: "=?ks_c_5601-1987?B?J7HoxKHIryc=?=" <willy@airpoint.co.kr>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: socket programming without RTnet.
Date: Fri, 9 Jan 2004 16:20:16 +0900
Message-ID: <00bc01c3d681$09486310$2a21a8c0@qha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <025c01c3d671$a30702a0$21589edd@CHKIMVAIO>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> What I want is to make some network applications just as I
> did with vxWorks. A 'network application' means using
> socket/bind/sendto/recvfrom etc APIs to send and receive data
> to/from outside of me or between internal tasks.

>
> I can't figure out what kernel space' and 'userland' mean.
> Well I am strange with embedded linux on ppc860 because I
> stayed with other RTOSs such as vxWorks and Nuclues. Would
> you explain more in detail?

I can see what you're trying to do. You're doing exactly the same thing
I've seen from embedded programmers just came to the great Linux world;
they often tend to call functions under #ifdef __KERNEL__. Don't do
that.

You should learn how to write a user application in linux environment.
i.e. You don't need {init,exit}_module, you don't define __KERNEL__ or
MODULE, you don't insmod to run your program. After that, the command
"man" should come in handy. e.g. man sendto, ...

Q-ha Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
