From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBEBC@helios.gnv.tcc.thomson-csf.com>
To: slowforce@21cn.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Minimal ramdisk
Date: Fri, 11 Jul 2003 11:16:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am currently using a non compressed file system that is around 1.6Mb.
So you should gain some place with compression.
Use BusyBox for your shell and commands ( 300Ko but you can remove options
).
For the lib I use standards libs but it must possible to find size optimized
libs.

Regards

Chris


> -----Message d'origine-----
> De: li [mailto:slowforce@21cn.com]
> Date: jeudi 10 juillet 2003 16:09
> À: linuxppc-embedded@lists.linuxppc.org
> Objet: Minimal ramdisk
>
>
>
> Hi all,
> My custom board has only 2Mbyte Flash memory
> i need to install an ppcboot, kernel image,
> file system, application and some parameters(several hundred
> bytes) on that memory.
> So a minimal ramdisk is very important to me.
> Does anyone have much experiments on this topic
> Thanks in advance!
> Regards!
> Li
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
