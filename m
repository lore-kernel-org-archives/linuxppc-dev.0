Return-Path: <achim.machura@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id C69F568905
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 02:36:03 +1100 (EST)
Received: from BATEEE52 (batee-e52.be-int [10.255.241.52])
	by pegasus.berghof.com (8.12.10/8.12.10) with SMTP id jBMFZwqg007955
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Dec 2005 16:35:58 +0100
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Jenkins, Clive'" <Clive.Jenkins@xerox.com>
Date: Thu, 22 Dec 2005 16:35:51 +0100
Message-ID: <001f01c6070d$649e8f00$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <35786B99AB3FDC45A8215724617919736D91B7@gbrwgceumf01.eu.xerox.net>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: Kernel cmdline
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Yes. Look at:
> http://lxr.linux.no/source/init/main.c?v=2.6.10;a=ppc#L123
> Clive

Thanks,

but this exaple seems to work only with modules staticly linked into the
kernel.

I' ve to parse the commandline in a dynamic loaded modul.

Achim
