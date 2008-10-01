Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep23-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id A606DDDFDF
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 03:36:34 +1000 (EST)
Received: from ng.localnet ([77.56.223.114]) by viefep23-int.chello.at
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20081001173632.QSLU29348.viefep23-int.chello.at@ng.localnet>
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 19:36:32 +0200
To: linuxppc-dev@ozlabs.org
Subject: Before adding preiliminary support for Netstal HCU4 (PPC405 based)
	board
From: Niklaus Giger <niklaus.giger@member.fsf.org>
Date: Wed, 1 Oct 2008 19:36:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810011936.19717.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I will soon submit a patch to add some support for a custom board.

I am a SW engineer at Netstal Maschinen in Switzerland. As I would like to get 
out of the current proprietary OS we currently are using, I have been 
following more or less closely the Linux kernel for quite a few years.
During more than one year I maintained a buildbot (continuos integegration)
for the xenomai realtime extension, which for various reasons I had no time
to continue in the last few months.

Since more than 3 years I have on my desk at home a PPC405 based board
(called HCU4) which has been running various linux version dating back to 
2.6.10. I do not know whether I will be succesfull in convincing my boss to 
use Linux but it would ease my job, if my board (and a little bit later its 
successor)  could find its way into the Linux kernel. He at least donated me 
the board(s) I am working on it.

The patch is fairly trivial, as it is more or less a clone of the Walnut 
board, minus some hardware not present. Having waited for the powerp port paid 
off, as the patch (after not having touched the Linux kernel for over 12 
months) was done (again) in two hours!

I hope that there are not too many stylistic. (After running 
scripts/checkpatch.pl I even rename <asm/time.h> to <linux/time.h>).

The board itself boots find and I was able to run quite a few test using the 
xenomai extensions. NFS, telnet, serial console, everything seems to work
fine.

The patch is against the master git of denx.de. It does not apply cleanly
against linus' git as I cannot find there any include/asm-ppc subdirectory. 
I cannot guarantee that I will do a checkout of all rc candidates made by 
Linus or Wolfgang, but I will try hard to do it for at least one of the 
release candidates for each version. If I cannot maintain may boards for 
longer than six months I will at last submit a change to remove them 
altogether if there are no more users. At least at the moment I do not know of 
anybody else. (There a are surely cheaper ways to get hand on a PPC405 board 
than buying one of our machines which are in the 6 to 7 digit price range.).

I would appreciate a small feedback, whether this is good form to submit 
patches.

Best regards and many thanks for everybody who contributed to make the powerpc 
architecture

-- 
NIklaus Giger
Wieshoschet 6
CH-8753 Mollis
+41  (0)55 612 20 54 P
+41  (0)55 618 64 68 G
