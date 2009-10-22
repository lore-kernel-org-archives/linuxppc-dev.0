Return-Path: <mohit.mewada@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id 234B8B7BAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 21:11:02 +1100 (EST)
Received: by ewy21 with SMTP id 21so6292748ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 03:10:59 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Oct 2009 15:40:59 +0530
Message-ID: <c432072d0910220310u65662499hc5b060d230d20e9c@mail.gmail.com>
Subject: Execute In Place (XIP) support for PPC440x5
From: Mohit Mewada <mohit.mewada@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi List,

I am trying to port a board with PPC440x5 on linux-2.6.31. My board
has 64MB of flash and 256KB of RAM. Since with this much RAM it is not
possible to copy the kernel image to RAM and boot it from there. I was
trying to figure-out option in the kernel which will allow me to
execute it from flash itself.

I refered to http://www.denx.de/wiki/publish/DULG/to-delete/ConfigureLinuxForXIP.html;
but the flags mentioned here are not present for PPC architecture. I
found these flag only for ARM architecture.

So can anyone please tell me whether it is possible to have kernel
executing from flash for PPC?
If yes, then please let me know about any patch or something that will
allow me  to do this?

--
Thanks and Regards,
Mohit Mewada
