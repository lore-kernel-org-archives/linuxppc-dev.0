Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CFF92FC.8070102@thales-bm.com>
Date: Thu, 06 Jun 2002 18:51:08 +0200
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Re: kernel command line for CRAMFS root filesystem]
References: <EADB10BAC266A14A85ECBF8686A73E31937F77@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


now it works !!


1) i have applied by hand the mkcramfs_endian.patch ( i have kernel
2.4.4 from denx )

2) i have added { "mtdblock", 0x1f00 } in init/main.c (that line is
missing in my kernel )

3) and the commandline (for me) is "root=/dev/mtdblock2 ..."

once again, thanks for all your advices ,

Julien



--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
