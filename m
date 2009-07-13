Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A975B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 17:16:49 +1000 (EST)
MIME-Version: 1.0
Date: Mon, 13 Jul 2009 12:46:45 +0530
Message-ID: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
Subject: Soft Reset for PPC44x Virtex 5 hangs saying Restarting System
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd2e2f8c60374046e911ab6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd2e2f8c60374046e911ab6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Kernel : Linux-2.6.29
Arch: Powerpc (ppc44x)
Target: Xilinx ML507 Virtex5

I have an issue in "Reset System" of Xilinx ML507 target board. I am using
Compact Flash to boot the target ( using system ACE file to boot the
target), during the process reset or reboot command on the target, I am not
able to reboot the target completely, here is the snapshot:

---------------------------------------------------------------------------------------------------

root@ml507:~# reboot

INIT: Sending processes the TERM signalWed Jul
INIT: Stopping OpenBSD Secure Shell server: sshdstopped /usr/sbin/sshd (pid
1052)
.
Stopping Vixie-cron.
Stopping network benchmark server: netserverstopped /usr/sbin/netserver (pid
1058)
.
Stopping syslogd/klogd: stopped syslogd (pid 1061)
stopped klogd (pid 1063)
done
NOT deconfiguring network interfaces: / is an NFS mount
Sending all processes the TERM signal...
Sending all processes the KILL signal...
hwclock: can't open '/dev/misc/rtc': No such file or directory
Unmounting remote filesystems...
Deactivating swap...
/etc/rc6.d/S40umountfs: line 9: swapoff: not found
Unmounting local filesystems...
umount2: Device or resource busy
umount: none busy - remounted read-only
Rebooting... Restarting system.                 <--------------- Target
hangs here..

-----------------------------------------------------------------------------------------------------

The target again doesn't provide me the boot options as obtained when done
hard reset :

Welcome to the Xilinx Virtex-5 ML507 Evaluation Platform Bootloader
Menu!


Please choose a demo by typing in the number of the demo you want to
use

Or select a demo using the directional buttons (C,W,S,E,N)
  (Then press the center (C) button to start the selected demo)

1. Virtex-5 Slide Show
2. Web Server Demo
3. Simon Game
4. Board Diagnostics (XROM)
5. USB Demo
6. My own ACE file
7. Ring Tone Player
Rebooting to System ACE Configuration Address 6...

zImage starting: loaded at 0x00800000 (sp: 0x00a44fb0)
Allocating 0x4e9138 bytes for kernel ...
gunzipping (0x00000000 <- 0x0080e000:0x00a437cc)...done 0x4a1bcc bytes


Any comments or suggestions are appreciated !!



Thanks
-Sriknt

--000e0cd2e2f8c60374046e911ab6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Kernel : Linux-2.6.29<br>Arch: Powerpc (ppc44x)<br>Target: X=
ilinx ML507 Virtex5<br><br>I have an issue in &quot;Reset System&quot; of X=
ilinx ML507 target board. I am using Compact Flash to boot the target ( usi=
ng system ACE file to boot the target), during the process reset or reboot =
command on the target, I am not able to reboot the target completely, here =
is the snapshot:<br>
<br>-----------------------------------------------------------------------=
----------------------------<br><br>root@ml507:~# reboot<br><br>INIT: Sendi=
ng processes the TERM signalWed Jul<br>INIT: Stopping OpenBSD Secure Shell =
server: sshdstopped /usr/sbin/sshd (pid 1052)<br>
.<br>Stopping Vixie-cron.<br>Stopping network benchmark server: netserverst=
opped /usr/sbin/netserver (pid 1058)<br>.<br>Stopping syslogd/klogd: stoppe=
d syslogd (pid 1061)<br>stopped klogd (pid 1063)<br>done<br>NOT deconfiguri=
ng network interfaces: / is an NFS mount<br>
Sending all processes the TERM signal...<br>Sending all processes the KILL =
signal...<br>hwclock: can&#39;t open &#39;/dev/misc/rtc&#39;: No such file =
or directory<br>Unmounting remote filesystems...<br>Deactivating swap...<br=
>
/etc/rc6.d/S40umountfs: line 9: swapoff: not found<br>Unmounting local file=
systems...<br>umount2: Device or resource busy<br>umount: none busy - remou=
nted read-only<br>Rebooting... Restarting system.=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 &lt;--------------- Target hangs here..<br>
<br clear=3D"all">---------------------------------------------------------=
--------------------------------------------<br><br>The target again doesn&=
#39;t provide me the boot options as obtained when done hard reset :<br><br=
>
Welcome to the Xilinx Virtex-5 ML507 Evaluation Platform Bootloader Menu!=
=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>Please choose a demo by typing in =
the number of the demo you want to use=A0=A0=A0=A0=A0=A0=A0 <br>
<br>Or select a demo using the directional buttons (C,W,S,E,N)<br>=A0 (Then=
 press the center (C) button to start the selected demo)<br><br>1. Virtex-5=
 Slide Show<br>2. Web Server Demo=A0=A0=A0 <br>3. Simon Game=A0=A0=A0=A0=A0=
=A0=A0=A0 <br>4. Board Diagnostics (XROM)<br>
5. USB Demo=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>6. My own ACE =
file=A0=A0=A0=A0=A0=A0=A0=A0 <br>7. Ring Tone Player=A0=A0=A0=A0=A0=A0=A0 <=
br>Rebooting to System ACE Configuration Address 6...<br><br>zImage startin=
g: loaded at 0x00800000 (sp: 0x00a44fb0)<br>Allocating 0x4e9138 bytes for k=
ernel ...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
gunzipping (0x00000000 &lt;- 0x0080e000:0x00a437cc)...done 0x4a1bcc bytes<b=
r><br><br>Any comments or suggestions are appreciated !!<br><br><br><br>Tha=
nks<br>-Sriknt<br><br><br><br><br>

--000e0cd2e2f8c60374046e911ab6--
