Return-Path: <robbinmathew@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.192])
	by ozlabs.org (Postfix) with ESMTP id 156A1688DC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 02:14:28 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so669768wxd
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Dec 2005 07:14:27 -0800 (PST)
Message-ID: <5b74ec4d0512180714r178223f6ub60df08a7ef78fc9@mail.gmail.com>
Date: Sun, 18 Dec 2005 20:44:27 +0530
From: Robin Mathew <robbinmathew@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2466_25750897.1134918867226"
Subject: x86 gdb with ppc8xx gdbserver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2466_25750897.1134918867226
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
We are trying to setup gdbserver and gdb for target debugging. We were able
to connect and debug with eldk's ppc8xx/gdb and ppc8xx gdbserver without an=
y
issues.

But I am not able to compile gdb in x86 for ppc8xx target. Can you please
point to some source tree of gdb that can be compiled for x86 platform for
ppc8xx target? I tried with gdb version 6.4 but it does not take
--target=3Dppc8xx option. I think the option that I am using to compile for
target is not right.

Any help in this regard is greatly appreciated.

Thanks,
Robin

------=_Part_2466_25750897.1134918867226
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
We are trying to setup gdbserver and gdb for target debugging. We were
able to connect and debug with eldk's ppc8xx/gdb and ppc8xx gdbserver
without any issues.<br>
<br>
But I am not able to compile gdb in x86 for ppc8xx target. Can you
please point to some source tree of gdb that can be compiled for x86
platform for ppc8xx target? I tried with gdb version 6.4 but it does
not take --target=3Dppc8xx option. I think the option that I am using to
compile for target is not right.<br>
<br>
Any help in this regard is greatly appreciated.<br>
<br>
Thanks,<br>
Robin<br>

------=_Part_2466_25750897.1134918867226--
