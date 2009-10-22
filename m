Return-Path: <embeddeddeveloper2009@gmail.com>
Received: from mail-fx0-f219.google.com (mail-fx0-f219.google.com
	[209.85.220.219]) by ozlabs.org (Postfix) with ESMTP id 90186B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 22:18:37 +1100 (EST)
Received: by fxm19 with SMTP id 19so9199946fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 04:18:34 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Oct 2009 16:48:33 +0530
Message-ID: <c3293e780910220418p36e1599cj8f60f001cb28e488@mail.gmail.com>
Subject: Query: Does Linux kernel 2.6.31 support read/write/erase on ST make
	M29W128GH Flash memory chip?
From: prakash bedge <embeddeddeveloper2009@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Linuxppc-embedded@ozlabs.org
Content-Type: multipart/alternative; boundary=001485f792b682b0a50476844180
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f792b682b0a50476844180
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I am searching for M29W128GH support in Linux kernel 2.6.31.
On internet I am seeing that there is some patch work for fixup on write
buffer coomand on M29W128GH. This shows that Linux kernel 2.6.31 supports
the M29W128GH.
But I am not seeing any memory mapping for M29W128GH.

Can anyone please tell me that whether Linux kernel 2.6.31 support the
read/write/erase on M29W128GH? If yes how I can check that?
Which of below files I should use for communicating with ST M29W128GH flash
chip?
cfi_cmdset_0001.c
cfi_cmdset_0002.c
cfi_cmdset_0020.c -- Looks like I shall use this but not confirm.
cfi_probe.c

I am novice to flash driver in kernel so might be not getting the exact
details on M29W128GH.
Expecting a help from seniors in this field.

Thanks in advance.


Thanks & Regards,
Aakash

--001485f792b682b0a50476844180
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi All,</div>
<div>=A0</div>
<div>I am searching for M29W128GH support in Linux kernel 2.6.31.</div>
<div>On internet I am seeing that there is some patch work for fixup on wri=
te buffer coomand on M29W128GH. This shows that Linux kernel 2.6.31 support=
s the M29W128GH.</div>
<div>But I am not seeing any memory mapping for M29W128GH.</div>
<div>=A0</div>
<div>Can anyone please tell me that whether Linux kernel 2.6.31 support the=
 read/write/erase on M29W128GH? If yes how I can check that?</div>
<div>Which of below files I should use for communicating with ST M29W128GH =
flash chip?</div>
<div>cfi_cmdset_0001.c</div>
<div>cfi_cmdset_0002.c</div>
<div>cfi_cmdset_0020.c -- Looks like I shall use this but not confirm.</div=
>
<div>cfi_probe.c</div>
<div>=A0</div>
<div>I am novice to flash driver in kernel so might be not getting the exac=
t details on M29W128GH. </div>
<div>Expecting a help from seniors in this field.</div>
<div>=A0</div>
<div>Thanks in advance.</div>
<div>=A0</div>
<div>=A0</div>
<div>Thanks &amp; Regards,</div>
<div>Aakash</div>

--001485f792b682b0a50476844180--
