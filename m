Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60DE6B70AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 19:44:34 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id B66B1DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 19:44:33 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so42405qwd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 02:44:31 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Jun 2009 15:14:31 +0530
Message-ID: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
Subject: 85xx Address space query
From: kernel mailz <kernelmailz@googlemail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0015175cb3003ded25046d14f430
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175cb3003ded25046d14f430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am a newbie, trying to learn but have a few queries, nice if you could
respond
For linux on 85xx systems...

(a) Kernel code runs in PR=0 AS=0 and PID=0, which user space application
run in PR=1 AS=0 and PID 1-255.
Is this correct.

(b) I am writing a small program where the application code opens invokes a
ioctl call and passes a buffer pointer ( say 0x10000 in user space)
Now the driver code is using copy_from_user.
How this works internally ?

1. User code executes ioctl
2. interrupt goes to the kernel
3. ioctl handler in driver gets invoked
The buffer pointer still contains 0x10000.

How kernel code running in PR=0 accesses it and does the copy. I am not able
to see a address space switch in the asm code of copy_tofrom_user.

Please respond

-TRX

--0015175cb3003ded25046d14f430
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am a newbie, trying to learn but have a few queries, nice if y=
ou could respond<br>For linux on 85xx systems...<br><br>(a) Kernel code run=
s in PR=3D0 AS=3D0 and PID=3D0, which user space application run in PR=3D1 =
AS=3D0 and PID 1-255.<br>
Is this correct.<br><br>(b) I am writing a small program where the applicat=
ion code opens invokes a ioctl call and passes a buffer pointer ( say 0x100=
00 in user space)<br>Now the driver code is using copy_from_user.<br>How th=
is works internally ?<br>
<br>1. User code executes ioctl<br>2. interrupt goes to the kernel<br>3. io=
ctl handler in driver gets invoked<br>The buffer pointer still contains 0x1=
0000. <br><br>How kernel code running in PR=3D0 accesses it and does the co=
py. I am not able to see a address space switch in the asm code of copy_tof=
rom_user.<br>
<br>Please respond<br><br>-TRX<br><br><br><br>

--0015175cb3003ded25046d14f430--
