From: Ruedi.Hofer@ascom.ch
Date: Thu, 06 Jul 2000 16:46:59 +0100 (CED)
Subject: Re: Mvista Kernel on FADS 860
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0FXA0064T6EGQK@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_kUadz9gaYBRPBSj/F1KL6w)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_kUadz9gaYBRPBSj/F1KL6w)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Although I know that FADS is a bad choice, some more info concerning this problem:
(I have no solution yet)

I'm referring to hardhat 1.1, kernel source 2.2.13.7.

In several files (eg include/asm-ppc/mpc8xx.h) I found lines containing
#ifdef CONFIG_FADS
...
#endif
Therefore I think I should be able to configure FADS somewhere in the kernel config menu.
Unfortunately, I am not!

All my trials failed of adding the #define to the file arch/ppc/config.in. Example:
  choice 'Machine Type' \
        "PowerMac       CONFIG_PMAC \
         PReP/MTX       CONFIG_PREP \
         CHRP           CONFIG_CHRP \
         PowerMac/PReP/CHRP     CONFIG_ALL_PPC \
         APUS           CONFIG_APUS \
         MBX            CONFIG_MBX \
         RPXL           CONFIG_RPXLITE \
         RPXC           CONFIG_RPXCLASSIC \
         EST8xx         CONFIG_EST8xx \
***         FADS           CONFIG_FADS \
         BSE-IP         CONFIG_BSEIP" PowerMac


Any ideas?

/Ruedi



PS: I even have a problem compiling the newly installed hardhat kernel 2.2.13.7. (Without
changing anything, just typing make dep && make zImage!)
I get 'FEC_INTERRUPT'  undeclared in fec.c!

--Boundary_(ID_kUadz9gaYBRPBSj/F1KL6w)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
