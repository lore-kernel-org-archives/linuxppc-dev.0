Date: Sun, 22 Aug 2004 00:51:18 +0200
From: Olaf Hering <olh@suse.de>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 hoses 2.4 on old-world?
Message-ID: <20040821225118.GB18858@suse.de>
References: <p06100200bd4c49c3daeb@[192.168.0.23]> <p06100203bd4c5e3aa6d9@[192.168.0.23]> <p06100204bd4c604f23ac@[192.168.0.23]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <p06100204bd4c604f23ac@[192.168.0.23]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Fri, Aug 20, Stefan Jeglinski wrote:

>
> >Steps:
> >
> >make menuconfig
> >(do some config)
> >make
> >make modules_install
> >reboot
>
> Confirmed. Something about this procedure with 2.6.8-rc4 is hosing
> /dev/null, and I have to delete it and mknod again. Is this a known
> bug, or have I discovered something that everybody's known about
> forever, and I should slink away. Or maybe I don't understand how to
> build/install 2.6 correctly?

for starters:

useradd -m jeglin
su - jeglin
tar xfj linux-2.6.8.1.tar.bz2
cd linux-2.6.8.1
make menuconfig
make all
cd ~jeglin/linux-2.6.8.1
make modules_install
reboot

the binutils check (?) will remove /dev/null

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
