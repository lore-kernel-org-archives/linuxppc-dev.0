Return-Path: <lcsquare2@yahoo.com.hk>
Received: from web53707.mail.yahoo.com (web53707.mail.yahoo.com
	[206.190.37.28]) by ozlabs.org (Postfix) with SMTP id B610B689DD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 19:43:39 +1100 (EST)
Message-ID: <20060111083657.77699.qmail@web53707.mail.yahoo.com>
Date: Wed, 11 Jan 2006 16:36:57 +0800 (CST)
From: Lo Chun Chung <lcsquare2@yahoo.com.hk>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-72912124-1136968617=:75039"
Subject: Can ELDK 3.1.1 compile Linux 2.6 Kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-72912124-1136968617=:75039
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Dear all,
   
  I just downloaded ELDK 3.1.1 (from denx) and LINUX kernel 2.6 (from kernel.org), and I compile the kernel for powerpc arch.
   
  but during I compile to the file under the directory vdso32, the following compile errors occur:
   
  arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
  arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: `.cfi_startproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:30: Error: unknown pseudo-op: `.cfi_register'
    arch/powerpc/kernel/vdso32/gettimeofday.S:73: Error: unknown pseudo-op: `.cfi_endproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:83: Error: unknown pseudo-op: `.cfi_startproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:91: Error: unknown pseudo-op: `.cfi_register'
    arch/powerpc/kernel/vdso32/gettimeofday.S:205: Error: unknown pseudo-op: `.cfi_endproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:216: Error: unknown pseudo-op: `.cfi_startproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:240: Error: unknown pseudo-op: `.cfi_endproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:252: Error: unknown pseudo-op: `.cfi_startproc'
    arch/powerpc/kernel/vdso32/gettimeofday.S:323: Error: unknown pseudo-op: `.cfi_endproc'
  make[2]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
  make[1]: *** [arch/powerpc/kernel/vdso32] Error 2
  make: *** [arch/powerpc/kernel] Error 2
   
  What's wrong with my compiler? Or ELDK cannot compile 2.6 kernel? What I can do now?
   
  Thanks











Best regards,
Chung
_______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-72912124-1136968617=:75039
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Dear all,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I just downloaded ELDK 3.1.1 (from denx) and LINUX kernel 2.6 (from kernel.org), and I compile the kernel for powerpc arch.</DIV>  <DIV>&nbsp;</DIV>  <DIV>but during I compile to the file under the directory vdso32, the following compile errors occur:</DIV>  <DIV>&nbsp;</DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:</DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: `.cfi_startproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:30: Error: unknown pseudo-op: `.cfi_register'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:73: Error: unknown pseudo-op: `.cfi_endproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:83: Error: unknown pseudo-op: `.cfi_startproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:91: Error: unknown pseudo-op: `.cfi_register'</DIV>  <DIV> 
 <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:205: Error: unknown pseudo-op: `.cfi_endproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:216: Error: unknown pseudo-op: `.cfi_startproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:240: Error: unknown pseudo-op: `.cfi_endproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:252: Error: unknown pseudo-op: `.cfi_startproc'</DIV>  <DIV>  <DIV>arch/powerpc/kernel/vdso32/gettimeofday.S:323: Error: unknown pseudo-op: `.cfi_endproc'</DIV>  <DIV>make[2]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1</DIV>  <DIV>make[1]: *** [arch/powerpc/kernel/vdso32] Error 2</DIV>  <DIV>make: *** [arch/powerpc/kernel] Error 2</DIV>  <DIV>&nbsp;</DIV>  <DIV>What's wrong with my compiler? Or ELDK cannot compile 2.6 kernel? What I can do now?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks</DIV></DIV></DIV></DIV></DIV></DIV></DIV></DIV></DIV></DIV><BR><BR>Best
 regards,<br>Chung<p>_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-72912124-1136968617=:75039--
