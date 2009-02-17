Return-Path: <baykelper@yahoo.com>
Received: from web56204.mail.re3.yahoo.com (web56204.mail.re3.yahoo.com
	[216.252.110.213]) by ozlabs.org (Postfix) with SMTP id AF285DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 16:29:30 +1100 (EST)
Message-ID: <719599.32884.qm@web56204.mail.re3.yahoo.com>
Date: Mon, 16 Feb 2009 21:22:48 -0800 (PST)
From: gt bradley <baykelper@yahoo.com>
Subject: nfs booting PS3, mount failed.
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-207925052-1234848168=:32884"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-207925052-1234848168=:32884
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I'm trying to set up my PS3 to netboot (with an nfsroot).

I'm using instructions at http://www.kernel.org/pub/linux/kernel/people/geo=
ff/cell/ps3-howto/ps3-nfs-root-howto.txt

I've passed section 3 (using tftp) to verify network /dhcp etc.=A0=A0 (i.e.=
 I'm able to tftp-get a file to ps3 from kboot's ash shell (busybox).

i'm trying to mount the nfs server as per section 4. with
 ~# mount -t nfs -o nolock 192.168.99.1:/target /mnt/remote

I get the following error message:
  mount: mounting 192.168.99.1:/target on /mnt/remote failed

if I boot the PS3 from the HD, then I am able to mount the nfs directory.
Using wireshark, I can see the initial dhcp traffic, (and when present the =
tftp traffic).
the mount command doesn't open a network connection to the server,=20
So I have pretty much ruled out server configuration.

running "strings" on the decompressed kboot image yeilds serveral nfs symbo=
ls, so it=20
appears to still support nfs mounting.  (using version kboot-20080609.bld f=
rom geoff's dir at kernel.org)
I have tried googling, and searching the various mailing lists, but am stuc=
k.

any help would be appreciated
GT


=0A=0A=0A      
--0-207925052-1234848168=:32884
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">I'm trying to set up my PS3 to netboot (with =
an nfsroot).<br><br>I'm using instructions at http://www.kernel.org/pub/lin=
ux/kernel/people/geoff/cell/ps3-howto/ps3-nfs-root-howto.txt<br><br>I've pa=
ssed section 3 (using tftp) to verify network /dhcp etc.&nbsp;&nbsp; (i.e. =
I'm able to tftp-get a file to ps3 from kboot's ash shell (busybox).<br><br=
>i'm trying to mount the nfs server as per section 4. with<br><pre> ~# moun=
t -t nfs -o nolock 192.168.99.1:/target /mnt/remote<br><br>I get the follow=
ing error message:<br>  mount: mounting 192.168.99.1:/target on /mnt/remote=
 failed<br><br>if I boot the PS3 from the HD, then I am able to mount the n=
fs directory.<br>Using wireshark, I can see the initial dhcp traffic, (and =
when present the tftp traffic).<br>the mount command doesn't open a network=
 connection to the server, <br>So I have pretty much ruled out server
 configuration.<br><br>running "strings" on the decompressed kboot image ye=
ilds serveral nfs symbols, so it <br>appears to still support nfs mounting.=
  (using version kboot-20080609.bld from geoff's dir at kernel.org)<br></pr=
e>I have tried googling, and searching the various mailing lists, but am st=
uck.<span style=3D"font-family: monospace;"><br><br>any help would be appre=
ciated<br>GT<br><br><br></span></td></tr></table><br>=0A=0A      
--0-207925052-1234848168=:32884--
