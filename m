Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <009801c2f97f$d8917790$1464a8c0@sjeng3>
From: "Xiaolong Li" <lxl@softhome.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2?
Date: Wed, 2 Apr 2003 17:24:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

I am currently working on IBM's 440GP Ebony evaluation board,
trying to run Linux on it. I installed ELDK 2.0.2 on RedHat 7.1,
and sucessfully compiled ppcboot, which runs smoothly on 440GP.

Now I am trying to build a Linux kernel 2.4.4 (which is included in
ELDK 2.0.2), but I see some errors regarding to mfdcr/DCRN_EXISR.

My question is: have anybody successfully built a Linux 2.4.4 kernel
for ppc 440GP/Ebony board? what changes did you make to the
kernel source to have it work? is there any patch available?

Thanks,

El

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
