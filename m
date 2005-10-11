Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep9.connect.com.au (fep9.mfe.bur.connect.com.au [203.63.86.9])
	by ozlabs.org (Postfix) with ESMTP id E502C68519
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 11:02:00 +1000 (EST)
Message-ID: <434B0F0F.9030601@rftechnology.com.au>
Date: Tue, 11 Oct 2005 11:02:07 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20051010234614.1FE2A353D84@atlas.denx.de>
In-Reply-To: <20051010234614.1FE2A353D84@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry for 3d email. The failed line I sent was incorrect - the problem 
is that debugger jumps from line to line on every step.
I have added -fno-schedule-insns -fno-schedule-insns2 into kernel Makefile:
CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common \
                    -ffreestanding \
                    -fno-schedule-insns -fno-schedule-insns2
But it still jumping. What options shall I add in order to prevent 
debugger jumping while debugging kernel?
Sorry, for slight off-topic.
Thank you
