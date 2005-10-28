Return-Path: <simlo@phys.au.dk>
Received: from lirs02.phys.au.dk (lirs02.phys.au.dk [130.225.28.43])
	by ozlabs.org (Postfix) with ESMTP id 75D91685C0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 18:03:37 +1000 (EST)
Date: Fri, 28 Oct 2005 09:49:55 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: =?ISO-8859-1?Q?=CF=C4=D3=EA?=  <xiay@nari-relays.com>
In-Reply-To: <200510281054.AA34079032@NARI-RELAYS.COM>
Message-Id: <Pine.OSF.4.05.10510280948570.21523-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: NFS can not mount (linuxppc2.2.4 mpc5200 lxt971)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Fri, 28 Oct 2005, =CF=C4=D3=EA  wrote:

> I have ported linuxppc2.2.4 to my board based on ICECUBE.
> One board can not mount NFS(eth0 =3D lxt971), Message as follow:
>=20
> eth0: config: auto-negotiation on, 100HDX, 10HDX.
> IP-Config: Complete:
>       device=3Deth0, addr=3D198.87.102.211, mask=3D255.255.255.0, gw=3D19=
8.87.102.140,
>      host=3Doops, domain=3D, nis-domain=3D(none),
>      bootserver=3D198.87.102.140, rootserver=3D198.98.102.140, rootpath=
=3D
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 198.98.102.140
> eth0: status: link up, Unknown speed/duplex, auto-negotiation complete, r=
emote f
> ault.
> portmap: server 198.98.102.140 not responding, timed out
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 198.98.102.140
> portmap: server 198.98.102.140 not responding, timed out
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 198.98.102.140 not responding, timed out
> Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_82xx
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or 02:00
> Please append a correct "root=3D" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00
>=20
> But i can ping the board from my PC:
>=20
> Pinging 198.87.102.211 with 32 bytes of data:
>=20
> Reply from 198.87.102.211: bytes=3D32 time<10ms TTL=3D64
> Reply from 198.87.102.211: bytes=3D32 time<10ms TTL=3D64
> Reply from 198.87.102.211: bytes=3D32 time<10ms TTL=3D64
> Reply from 198.87.102.211: bytes=3D32 time<10ms TTL=3D64
>=20
>=20
> The other boards using the same program can mount NFS on the same server.
>=20
> What part of this board might be wrong?=20
>=20
I can't tell you what is wrong, but I have seen the same error:
It works fine on the Lite5200 proto board but not on our custom board :-(

Esben


> Thanks!
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
