Return-Path: <lk.atwork@yahoo.com>
Received: from n74a.bullet.mail.sp1.yahoo.com (n74a.bullet.mail.sp1.yahoo.com
	[98.136.45.21]) by ozlabs.org (Postfix) with SMTP id 2552CDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 13:11:44 +1100 (EST)
Date: Thu, 23 Oct 2008 19:05:20 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: cuImage not building
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-981557971-1224813920=:86157"
Message-ID: <423286.86157.qm@web46307.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-981557971-1224813920=:86157
Content-Type: text/plain; charset=us-ascii

Hi,

I have gotten our MPC8347 based board to work under Linux-2.6.27.1.

Since our board is similar to mpc834x_mds, I initially modified files relevant
to mpc834x_mds to get our board working.

Now I'm trying to rename files so that they reflect our board names.

After this renaming, uImage gets built ok, but cuImage build fails. 
I enabled make's verbose flag to see what was going on
and here are the error messages

+ powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.snsp arch/powerpc/boot/cuboot-snsp.o ./zImage.15886.o arch/powerpc/boot/wrapper.a
powerpc-unknown-linux-gnu-ld: arch/powerpc/boot/cuboot-snsp.o: No such file: No such file or directory

Here is the build invocation with mpc834x_mds files.

+ powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.mpc834x_mds arch/powerpc/boot/cuboot-83xx.o ./zImage.3158.o arch/powerpc/boot/wrapper.a

>From the two invocations, not working code gets called with arch/powerpc/boot/cuboot-snsp.o
whereas working code gets called with arch/powerpc/boot/cuboot-83xx.o.

I have made relevant changes to appropriate Makefiles, but I still cant get cuImage to build.

can someone help?
thanks a lot
LK


      
--0-981557971-1224813920=:86157
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I have gotten our MPC8347 based board to work under Linux-2.6.27.1.<br><br>Since our board is similar to mpc834x_mds, I initially modified files relevant<br>to mpc834x_mds to get our board working.<br><br>Now I'm trying to rename files so that they reflect our board names.<br><br>After this renaming, uImage gets built ok, but cuImage build fails. <br>I enabled make's verbose flag to see what was going on<br>and here are the error messages<br><br>+ powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.snsp arch/powerpc/boot/cuboot-snsp.o ./zImage.15886.o arch/powerpc/boot/wrapper.a<br>powerpc-unknown-linux-gnu-ld: arch/powerpc/boot/cuboot-snsp.o: No such file: No such file or directory<br><br>Here
 is the build invocation with mpc834x_mds files.<br><br>+ powerpc-unknown-linux-gnu-ld -m elf32ppc -T arch/powerpc/boot/zImage.lds -Ttext 0x400000 --defsym _start=0x400000 -o arch/ppc/boot/cuImage.mpc834x_mds arch/powerpc/boot/cuboot-83xx.o ./zImage.3158.o arch/powerpc/boot/wrapper.a<br><br>From the two invocations, not working code gets called with arch/powerpc/boot/cuboot-snsp.o<br>whereas working code gets called with arch/powerpc/boot/cuboot-83xx.o.<br><br>I have made relevant changes to appropriate Makefiles, but I still cant get cuImage to build.<br><br>can someone help?<br>thanks a lot<br>LK<br><br></div></div><br>

      </body></html>
--0-981557971-1224813920=:86157--
