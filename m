Date: Tue, 9 Dec 2003 17:56:33 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: AlessandroPPC <aleppcrossi@libero.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: busybox problem
In-Reply-To: <007b01c3be71$6ec82c20$0400a8c0@eurostudio.local>
Message-ID: <Pine.LNX.4.44.0312091755210.6152-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

rc.sh is a script so needs /bin/sh or something
do you use shared libraries? That might give
problems

Jaap-Jan

On Tue, 9 Dec 2003, AlessandroPPC wrote:

>
> Hi to all,
>
> To solve a problem with ram root filesystem Wolfgang Denk has suggestes to
> me  to use his
> SELF ramdisk image.
> I have successfully used his package.
> But I have found a problem with BusyBox init, when T have tried to
> customized the init board
> configuration.
> The problem is related to /etc/rc.sh init script, in fact editing rc.sh and
> rebuilding the ramdisk
> image the output init is the following:
>
>
>   "Bummer, could not run '/etc/rc.sh': No such device or directory"
>
> Notice that /etc/rc.sh is present, is an exutable file and has root
> privileges.
>
> Any suggestion is appreciated.
> R.R.C.S.C.
>
> Thanks to all
> Regards,
> Alessandro
>
>
>

--
---
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
