Date: Sun, 13 Feb 2000 21:16:29 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Jack Howarth <howarth@bromo.med.uc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-pmac-devel
In-Reply-To: <200002140006.QAA49713@bromo.med.uc.edu>
Message-ID: <Pine.LNX.4.20.0002132115280.7804-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


yes. it's probably an easy fix but then you could just use make
menuconfig.

>
>    I think there is error somewhere in the config scripts in the 2.3.xx
> tree. When I rsync, do a make clean and then make config I get...
>
> *
> * General setup
> *
> scripts/Configure: [: missing `]'
> Networking support (CONFIG_NET) [Y/n/?]
> Sysctl support (CONFIG_SYSCTL) [Y/n/?] make: *** [config] Error 1
>
> Is anyone else seeing this now?
>                Jack
>

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
