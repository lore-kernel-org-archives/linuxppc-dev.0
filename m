Return-Path: <baishuwei@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 8D20ADDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 13:32:35 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so372152nfd
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:32:34 -0700 (PDT)
Message-ID: <f3566d60710182032h69e2d2bejafd96f18dae95829@mail.gmail.com>
Date: Fri, 19 Oct 2007 11:32:33 +0800
From: "Bai Shuwei" <baishuwei@gmail.com>
To: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: powerpc 440 monitor program
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4687_32391004.1192764753409"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4687_32391004.1192764753409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

all,
    hi, when I boot my system, there are no output on the screen.
I choice the framebuffer and my monitor card is ATI PAGE 128 PCI, qt/e GUI.
When i compile the kernel, the boot logo and aty 128fb has be compiled into
kernel patched with videoboot, and x86emu. The video parameters set:
     video=aty128fb:640x480-16@7.
    The kenel can recognize the monitor card, and the frame buffer device
has run.
The output showed below:

    videoboot: Booting PCI video card bus 0, function 0, device 6
   aty128fb: Found Intel x86 BIOS ROM Image
   aty128fb: Rage128 BIOS located
   aty128fb: Rage128 RK PCI [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)
   fb0: ATY Rage128 frame buffer device on Rage128 RK PCI

My problem is there is no output on the monitor,and cannot see the penguin
boot logo.
I also run a program to test the framebuffer, which can read data from the
fb. After running the qt/e program, which can run scussessfully, there is no
output.!
   The test program reading data are showed below;


id = ATY Rage128
depth =  16
smemlen = 33554432
line_length = 0
FB_TYPE_ = 0
type_aux = 0
FB_VISUAL_ = 3
xpanstep = 8
ypanstep = 1
ywrapstep = 0
mmio_start = bbffc0000d
mmio_len = 8192
accel = 32
xres = 640
yres = 480
xres_virtul = 640
yres_virtul = 480
xoffset = 0
yoffset = 0
bits_per_pixel = 16

         My linux kernel is DENX 2.6.19.

        What can I do to make my system output into monitor.?

best regards!

buroc
-- 

Add: Tianshui South Road 222, Lanzhou, P.R.China
Tel: +86-931-8912025
Zip Code: 730000
URL: oss.lzu.edu.cn
Email: baishuwei@gmail.com, buroc@126.com

Tel: +86-931-8912025
Zip Code: 730000
URL: oss.lzu.edu.cn
Email: baishuwei@gmail.com, buroc@126.com

------=_Part_4687_32391004.1192764753409
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br clear="all">all, </div>
<div>&nbsp;&nbsp;&nbsp; hi, when I boot my system, there are no output on the screen. I&nbsp;choice&nbsp;the framebuffer and my monitor card is ATI PAGE 128 PCI, qt/e GUI. When i compile the kernel, the boot logo and aty 128fb has be compiled into kernel patched with videoboot, and x86emu. The video parameters set:
</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;video=aty128fb:640x480-16@7.</div>
<div>&nbsp;&nbsp;&nbsp; The kenel can recognize the monitor card, and the frame buffer device has run.</div>
<div>The output showed below:<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; videoboot: Booting PCI video card bus 0, function 0, device 6<br>&nbsp;&nbsp; aty128fb: Found Intel x86 BIOS ROM Image<br>&nbsp;&nbsp; aty128fb: Rage128 BIOS located<br>&nbsp;&nbsp; aty128fb: Rage128 RK PCI [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)
<br>&nbsp;&nbsp;&nbsp;fb0: ATY Rage128 frame buffer device on Rage128 RK PCI<br>&nbsp;</div>
<div>My problem is there is no output on the monitor,and cannot see the penguin boot logo. </div>
<div>I also run a program to test the framebuffer, which can read data from the fb. After running the qt/e program, which can run scussessfully, there is no output.!</div>
<div>&nbsp;&nbsp; The test program reading data are showed below;</div>
<div>&nbsp;<br><br>id = ATY Rage128<br>depth =&nbsp; 16<br>smemlen = 33554432<br>line_length = 0<br>FB_TYPE_ = 0<br>type_aux = 0<br>FB_VISUAL_ = 3<br>xpanstep = 8<br>ypanstep = 1<br>ywrapstep = 0<br>mmio_start = bbffc0000d<br>mmio_len = 8192
<br>accel = 32<br>xres = 640<br>yres = 480<br>xres_virtul = 640<br>yres_virtul = 480<br>xoffset = 0<br>yoffset = 0<br>bits_per_pixel = 16<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My linux kernel is DENX 2.6.19. </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; What can I do to make my system output into monitor.? <br clear="all"></div>
<div>
<div>&nbsp;</div>
<div>best regards!</div>
<div>&nbsp;</div>
<div>buroc<br>-- <br><br>Add: Tianshui South Road 222, Lanzhou, P.R.China<br>Tel: +86-931-8912025<br>Zip Code: 730000<br>URL: <a href="http://oss.lzu.edu.cn">oss.lzu.edu.cn</a><br>Email: <a href="mailto:baishuwei@gmail.com">
baishuwei@gmail.com</a>, <a href="mailto:buroc@126.com">buroc@126.com</a> </div><br>Tel: +86-931-8912025<br>Zip Code: 730000<br>URL: <a href="http://oss.lzu.edu.cn">oss.lzu.edu.cn</a><br>Email: <a href="mailto:baishuwei@gmail.com">
baishuwei@gmail.com</a>, <a href="mailto:buroc@126.com">buroc@126.com</a> </div>

------=_Part_4687_32391004.1192764753409--
