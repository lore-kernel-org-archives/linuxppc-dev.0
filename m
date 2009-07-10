Return-Path: <Guenter.Leonhardt@men.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62214B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 19:08:13 +1000 (EST)
Received: from mail179.messagelabs.com (mail179.messagelabs.com
	[85.158.139.35]) by ozlabs.org (Postfix) with SMTP id 47305DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 19:08:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Memory usage of a process
Date: Fri, 10 Jul 2009 11:08:06 +0200
Message-ID: <D0B748CCD5DF144CA5C56A9D860A31341DE613@men-exch1.intra.men.de>
From: =?iso-8859-1?Q?G=FCnter_Leonhardt?= <Guenter.Leonhardt@men.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
Hello,
analysing the memory usage of a process, I found some questions.
I'am using a system with 128 MB physical RAM, no disk, 2.6.27 kernel.

Running top, I see 38 MB in use, 90 MB free, but a VSZ for my process of =
158 MB.
Looking at /proc/<pid>/maps, I see that the process uses 140 MB without =
shared libs.

So how it is possible that the process can allocate more memory than =
there is, without posibility of swapping?

Why said top that 90 MB free? Does the kernel serve the allocation only =
if ist really used?

G=FCnter
