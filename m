Mime-Version: 1.0
Message-Id: <p06100204bd4c604f23ac@[192.168.0.23]>
In-Reply-To: <p06100203bd4c5e3aa6d9@[192.168.0.23]>
References: <p06100200bd4c49c3daeb@[192.168.0.23]>
 <p06100203bd4c5e3aa6d9@[192.168.0.23]>
Date: Fri, 20 Aug 2004 22:18:16 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.6 hoses 2.4 on old-world?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Steps:
>
>make menuconfig
>(do some config)
>make
>make modules_install
>reboot

Confirmed. Something about this procedure with 2.6.8-rc4 is hosing
/dev/null, and I have to delete it and mknod again. Is this a known
bug, or have I discovered something that everybody's known about
forever, and I should slink away. Or maybe I don't understand how to
build/install 2.6 correctly?

I hear YDL-4 won't support BootX - is this convenience or is
something now permanently broken for old-world and kernel 2.6?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
