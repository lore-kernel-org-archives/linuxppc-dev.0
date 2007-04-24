Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 5348DDDF15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 21:31:49 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so1570554pyb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 04:31:47 -0700 (PDT)
Message-ID: <f87351060704240431m2218910cs65510472218459b0@mail.gmail.com>
Date: Tue, 24 Apr 2007 17:01:47 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: arch/powerpc for lite5200b
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Everyone,

I have been trying to get the linux-2.6.20-rt3 for arch/powerpc to
boot on my lite5200b. Here are the things that I have tried so far. I
have a custom board based on the lite5200b and then the evaluation
board too.

- I have a working 2.6.16-rt29 kernel compiled using ARCH=ppc for both
these boards.

- I tried the default configs for lite5200 for both the custom board
and the EVB. Both hang at "Transferring control to Linux (at address
00000000) ..."

- I downloaded roberts
http://www.pengutronix.de/oselas/bsp/phytec/index_en.html#phyCORE-MPC5200B-tiny
patches, but still ended up with the same result.

I read ( http://www.nabble.com/Re%3A-MPC52xx-support-rework-for-2.6.20-p7568655.html
)  that the arch/powerpc port for lite5200 works right out of the box.
Am I doing something wrong ?

The one thing I am yet to try is to do a git checkout from
git.secretlabs.ca. Unfortunately thanks to some internal firewalling
policies I still have not been able to do that.

Thanks in advance
regards
prady
