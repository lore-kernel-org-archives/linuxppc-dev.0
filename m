From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Smith, Craig" <Craig.Smith@icn.siemens.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Dynamic lib loading & memory question
Date: Fri, 25 Jun 2004 18:44:10 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHEEKOCGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hello,
> I have a simple hello world program I'm trying to compile and run on a
> custom PPC(855T) board. It will work fine if I statically link the
> executable with the necessary libs. However if I don't statically link
> (relying on ld.so etc.), the program will core dump. My system has 16M of
> SDRAM (I just upgraded it from 8M and I believe it's configured right).
> Anyway, here's the output and other info that might help someone tell me
> what I'm doing wrong...thanks so much!
> ########################################
> ### The "bad" version:
> ########################################
> root@raptorlinux->~ [10] ./hw_ppc
> Segmentation fault (core dumped)

Examine the coredump with gdb. Disassemble the instructions around the
Seg. fault and post to the list.

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
