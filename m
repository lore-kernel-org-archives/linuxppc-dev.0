Return-Path: <lcsquare2@yahoo.com.hk>
Received: from web53703.mail.yahoo.com (web53703.mail.yahoo.com
	[206.190.37.24]) by ozlabs.org (Postfix) with SMTP id 4E63568A63
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 17:10:23 +1100 (EST)
Message-ID: <20060112061021.81186.qmail@web53703.mail.yahoo.com>
Date: Thu, 12 Jan 2006 14:10:21 +0800 (CST)
From: Lo Chun Chung <lcsquare2@yahoo.com.hk>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060111203725.28A82352B1E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1278884799-1137046221=:76970"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Re: Can ELDK 3.1.1 compile Linux 2.6 Kernel? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1278884799-1137046221=:76970
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Thanks.
   
  I am looking forward to this.

Wolfgang Denk <wd@denx.de> 說：
  In message <20060111083657.77699.qmail@web53707.mail.yahoo.com> you wrote:
> 
> I just downloaded ELDK 3.1.1 (from denx) and LINUX kernel 2.6 (from kernel.org), and I compile the kernel for powerpc arch.
> 
> but during I compile to the file under the directory vdso32, the following compile errors occur:
> 
> arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
> arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: `.cfi_startproc'
...

Yes, they changed the Linux kernel such that it cannot be compiled
any more using binutils version 2.14 which is used in ELDK 3.x

> What's wrong with my compiler? Or ELDK cannot compile 2.6 kernel? What I can do now?

Please wait until the end of the week, then download ELDK 4.0, then
be happy ;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering: Embedded and Realtime Systems, Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"To IBM, 'open' means there is a modicum of interoperability among
some of their equipment." - Harv Masterson
  



Best regards,
Chung
_______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-1278884799-1137046221=:76970
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Thanks.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am looking forward to this.<BR><BR><B><I>Wolfgang Denk &lt;wd@denx.de&gt;</I></B> 說：</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">In message &lt;20060111083657.77699.qmail@web53707.mail.yahoo.com&gt; you wrote:<BR>&gt; <BR>&gt; I just downloaded ELDK 3.1.1 (from denx) and LINUX kernel 2.6 (from kernel.org), and I compile the kernel for powerpc arch.<BR>&gt; <BR>&gt; but during I compile to the file under the directory vdso32, the following compile errors occur:<BR>&gt; <BR>&gt; arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:<BR>&gt; arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: `.cfi_startproc'<BR>...<BR><BR>Yes, they changed the Linux kernel such that it cannot be compiled<BR>any more using binutils version 2.14 which is used in ELDK 3.x<BR><BR>&gt; What's wrong with my compiler? Or ELDK cannot compile 2.6 kernel? What I can do
 now?<BR><BR>Please wait until the end of the week, then download ELDK 4.0, then<BR>be happy ;-)<BR><BR>Best regards,<BR><BR>Wolfgang Denk<BR><BR>-- <BR>Software Engineering: Embedded and Realtime Systems, Embedded Linux<BR>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<BR>"To IBM, 'open' means there is a modicum of interoperability among<BR>some of their equipment." - Harv Masterson<BR></BLOCKQUOTE>  <DIV><BR></DIV><BR><BR>Best regards,<br>Chung<p>_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-1278884799-1137046221=:76970--
