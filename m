Message-ID: <39AED82E.9D9FFA56@emc.com>
Date: Thu, 31 Aug 2000 18:11:58 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: General question on how to port linux kernel ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am a newbie to Linux kernel port.

Just want to ask some general questions regarding porting linux kernel.

1) I have experiences porting pSOS kernel on different custom board.
     Usually what I did is to bring the board to a known state and
provide
      some required parameters and I/O interfacces, then call an entry
point
      of the kernel. That is it.

      Is Linux porting similar to this process ? If yes ,

2)  Is there a well-defined known state before jumping into linux kernel
?

3)  Is linux kernel modulized ?  For example, to integrate a different
PCI
       bridge controller, which .c and .h files should I change ?

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
