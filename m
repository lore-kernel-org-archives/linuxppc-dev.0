Message-ID: <001301c3093d$ad9c69f0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial Console Login Fails
Date: Wed, 23 Apr 2003 07:41:40 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I am using IBM PPC 440 processor on custom board , which has no network
support. I am using Monta Vista Linux with ramdisk enabled. In the ramdisk ,
I have very less files. Since there is no network on the board , I am trying
to enable the serial console login. To achieve this, I disabled serial
console logging by saying "console=NULL " in the cmdline and in the
/etc/inittab file added this line
"T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100"
Bcos of which during the linux bootup , there wont be console message on the
screen , after some time , there is a login prompt
<none>login:
If I try login then it waits for some seconds and then display the same i.e
<none>login:

Can anybody help me in solving this issue?
Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
