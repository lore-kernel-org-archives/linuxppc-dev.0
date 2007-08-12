Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id 81969DDEEE
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 07:04:36 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so862858rvf
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 14:04:36 -0700 (PDT)
Message-ID: <5c9cd53b0708121404p5e2b8311l5a20ec481a6bed59@mail.gmail.com>
Date: Sun, 12 Aug 2007 17:04:35 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Error: unsupported relocation against CSRR0
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2474_5858464.1186952675603"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2474_5858464.1186952675603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have "unsupported relocation against" problem, while compiling entry.S in
2.4 Kernel against e500 core.  Does anyone know what is the problem? Is
there any option I missed?

Thanks in advance,

MikeZ


/kernel->   powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/kernel/.entry.o.d
-nostdinc -isystem
/opt/mtwk/usr/local/gcc-3_4-e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include
-D__KERNEL__ -Iinclude  -Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-me500    -c
-o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
arch/ppc/kernel/entry.S: Assembler messages:

entry.S:819: Error: unsupported relocation against CSRR0
entry.S:820: Error: unsupported relocation against CSRR1
entry.S:888: Error: unsupported relocation against MCSRR0
entry.S:889: Error: unsupported relocation against MCSRR1
entry.S:909: Error: unsupported relocation against CSRR0
entry.S:911: Error: unsupported relocation against CSRR1



entry.S

819   mtspr CSRR0, r11
820   mtspr CSRR1, r12

------=_Part_2474_5858464.1186952675603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>I have &quot;unsupported relocation against&quot; problem, while compiling entry.S in 2.4 Kernel against&nbsp;e500 core.&nbsp; Does anyone know what is the problem? Is there any option I missed?</div>
<div><br>Thanks in advance,</div>
<div>&nbsp;</div>
<div>MikeZ</div>
<div>&nbsp;</div>
<div>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font face="Courier New" size="2">/kernel-&gt;<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/kernel/.entry.o.d -nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4-
e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include -D__KERNEL__ -Iinclude<span style="mso-spacerun: yes">&nbsp; </span>-Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-me500<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>-c -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S<br>arch/ppc/kernel/entry.S: Assembler messages:</font></p><font face="Courier New" size="2">
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font face="Courier New" size="2">entry.S:819: Error: unsupported relocation against CSRR0<br>entry.S:820: Error: unsupported relocation against CSRR1<br>entry.S:888: Error: unsupported relocation against MCSRR0
<br>entry.S:889: Error: unsupported relocation against MCSRR1<br>entry.S:909: Error: unsupported relocation against CSRR0<br>entry.S:911: Error: unsupported relocation against CSRR1</font><br></p>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><br><br></p></font><font size="2"><font face="Courier New"><span lang="PT-BR" style="mso-ansi-language: PT-BR">entry.S<br><br>819<span style="mso-tab-count: 1">&nbsp;&nbsp; </span>
mtspr CSRR0, r11<br></span>820<span style="mso-tab-count: 1">&nbsp;&nbsp; </span>mtspr CSRR1, r12</font></font><br></div>

------=_Part_2474_5858464.1186952675603--
