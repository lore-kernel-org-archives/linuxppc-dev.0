Return-Path: <nareshgbhat@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 8319ADDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 16:42:47 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1890280wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 23:42:46 -0700 (PDT)
Message-ID: <cf9b3c760807222342h47ff8d0atd74fd5a583a62d9c@mail.gmail.com>
Date: Wed, 23 Jul 2008 12:12:45 +0530
From: "Naresh Bhat" <nareshgbhat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel is Hanging for page size 16KB.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11984_29810841.1216795365868"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11984_29810841.1216795365868
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys,

I have a board MIPS Malta and Linux 2.6.10 is running on that. By default
4KB page size will be allocated in the kernel (I mean to say I saw it when I
do the "make menuconfig".

Problem is:

When I changed the page size to 16KB it will hang after mounting the file
system. I am using the NFS for booting the board.


Can anybody help me on this issue...
-- 

Naresh Bhat

------=_Part_11984_29810841.1216795365868
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Guys,<br><br>I have a board MIPS Malta and Linux 2.6.10 is running on that. By default 4KB page size will be allocated in the kernel (I mean to say I saw it when I do the &quot;make menuconfig&quot;.<br><br>
Problem is:<br><br>When I changed the page size to 16KB it will hang after mounting the file system. I am using the NFS for booting the board.<br clear="all"><br><br>Can anybody help me on this issue...<br>-- <br><br>Naresh Bhat<br>
<br></div>

------=_Part_11984_29810841.1216795365868--
