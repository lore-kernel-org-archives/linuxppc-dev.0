From: "Vladimir Simonov" <sv@asplinux.ru>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: OF access after kernel boot
Date: Tue, 4 Jul 2000 20:39:41 +0400
Message-ID: <NEBBKFDEKEFCPABJIFOMKEBDCPAA.sv@sw.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20000704105105.E18342@xim.bellglobal.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks,
> man nvsetenv

> Without parameters, nvsetenv will give you the values of nvram
> registers.
I'm using linux-pmac-stable - 2.2.15pre19 on G4. And found that nvram.c
is not linked in spite of CONFIG_NVRAM=y.
Makefile in drivers/char contains
....
ifeq($(CONFIG_NVRAM),y)
	ifeq($(CONFIG_PPC),)
....
Is an absence of "y" a typo or has sence?
Any way nvram.c can't be compiled "for this machine configuration".
Does anybody know which versions of kernel permit
nvram using on G4, iBook?
Thanks again
Vladimir Simonov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
