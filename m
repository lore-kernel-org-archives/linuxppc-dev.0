Return-Path: <jyliu.linux@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id D7E3FDDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 15:19:23 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so904563wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 20:19:22 -0800 (PST)
Message-ID: <8dd3a8e00802142019y28c16e52sa9b676b2cc1d983d@mail.gmail.com>
Date: Thu, 14 Feb 2008 20:19:21 -0800
From: "Jingyu Liu" <jyliu.linux@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: a question on an error of building 2.6.24.2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6225_196786.1203049161919"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6225_196786.1203049161919
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

I am using a cross-compiler gcc 4.1.2 and glibc 2.3.6 to build 2.6.24.2 for
a adder875 board. At the end of  building, the ld gives the following error
messages:

  LD      init/built-in.o
  LD      vmlinux
`.exit.data' referenced in section `.exit.text' of drivers/built-in.o:
defined in discarded section `.exit.data' of drivers/built-in.o
`.exit.data' referenced in section `.exit.text' of drivers/built-in.o:
defined in discarded section `.exit.data' of drivers/built-in.o
`.exit.data' referenced in section `.exit.text' of drivers/built-in.o:
defined in discarded section `.exit.data' of drivers/built-in.o
`.exit.data' referenced in section `.exit.text' of drivers/built-in.o:
defined in discarded section `.exit.data' of drivers/built-in.o
make: *** [vmlinux] Error 1

.config file is also attached.

Is it gcc problem, or something else?

Thanks.

Jingyu

------=_Part_6225_196786.1203049161919
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,<br><br>I am using a cross-compiler gcc 4.1.2 and glibc 2.3.6 to build <a href="http://2.6.24.2/" target="_blank">2.6.24.2</a> for a adder875 board. At the end of&nbsp; building, the ld gives the following error messages:<br>
<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/built-in.o<br>
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmlinux<br>`.exit.data&#39;
referenced in section `.exit.text&#39; of drivers/built-in.o: defined in
discarded section `.exit.data&#39; of drivers/built-in.o<br>`.exit.data&#39;
referenced in section `.exit.text&#39; of drivers/built-in.o: defined in
discarded section `.exit.data&#39; of drivers/built-in.o<br>
`.exit.data&#39; referenced in section `.exit.text&#39; of drivers/built-in.o:
defined in discarded section `.exit.data&#39; of drivers/built-in.o<br>`.exit.data&#39;
referenced in section `.exit.text&#39; of drivers/built-in.o: defined in
discarded section `.exit.data&#39; of drivers/built-in.o<br>
make: *** [vmlinux] Error 1<br><br>.config file is also attached.<br><br>Is it gcc problem, or something else?<br><br>Thanks.<br><br>Jingyu<br><font color="#888888"><br></font>

------=_Part_6225_196786.1203049161919--
