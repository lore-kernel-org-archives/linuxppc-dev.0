From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8560 util.S compilation error with E500 core support
Date: Tue, 24 Aug 2004 18:36:23 +0200
Message-ID: <001301c489f8$82f426b0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I first download a 2.6.7 Linux kernel to port it to a custom 8560 board.
The ./arch/ppc/boot/common/util.S compiles fine.

Then I download a 2.6.8 kernel. The same file util.S does not
compile any more because of "mtsrin" instruction not found with E500.

Between the 2 kernels, the -me500 option is distributed all over the
./arch/ppc directory. So the ./arch/ppc/boot is compiled with this option
and fails.

What is the right solution ?
Compile the boot whitout -me500 option or change util.S code ?

Thanks for any idea.
Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
