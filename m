Return-Path: <kn.zahirkhan@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A3E3CB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 17:16:37 +1000 (EST)
MIME-Version: 1.0
Date: Fri, 17 Jul 2009 16:16:33 +0900
Message-ID: <f970d83a0907170016s239cc390s63f8d2d3987e3142@mail.gmail.com>
Subject: RE::New dma-noncoherent code, looking for comment and people to test
From: Zaahir Khan <kn.zahirkhan@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd172e6708308046ee19188
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd172e6708308046ee19188
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Remi Machet,


I am using sequoia PPC440EPx.

with

CONFIG_NOT_COHERENT_CACHE=y


I applied your patch

    file -->    arch/powerpc/lib/dma-noncoherent.c


After applying my board is not booting up on NFS.
If I use the old file its booting up normal.
Is this a bug or I missed something.

Error message ::

Looking up port of RPC 100003/2 on 192.168.1.10
Looking up port of RPC 100005/1 on 192.168.1.10
mount: server 192.168.1.10 not responding, timed out
Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_4xxFP
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available
partitions:




Thanks & regards,

Zaahir Khan

--000e0cd172e6708308046ee19188
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Remi Machet,<br><br><br>I am using sequoia PPC440EPx.<br><pre>with <br><=
br>CONFIG_NOT_COHERENT_CACHE=3Dy</pre><br>I applied your patch <br><br>=A0=
=A0=A0 file --&gt;=A0=A0=A0 arch/powerpc/lib/dma-noncoherent.c <br><br><br>=
After applying my board is not booting up on NFS.<br>
If I use the old file its booting up normal. <br>Is this a bug or I missed =
something.<br><br>Error message ::<br><br>Looking up port of RPC 100003/2 o=
n 192.168.1.10<br>Looking up port of RPC 100005/1 on 192.168.1.10<br>mount:=
 server 192.168.1.10 not responding, timed out<br>
Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_4xxFP<br>VF=
S: Unable to mount root fs via NFS, trying floppy.<br>VFS: Cannot open root=
 device &quot;nfs&quot; or unknown-block(2,0)<br>Please append a correct &q=
uot;root=3D&quot; boot option; here are the available partitions:<br>
<br><br><br><br clear=3D"all">Thanks &amp; regards,<br><br>Zaahir Khan<br>

--000e0cd172e6708308046ee19188--
