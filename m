Message-ID: <001401c3334f$c2e079f0$ca8d100a@justin>
From: "Shenrong" <rshen@udtech.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC755 L2 Cache data parity error
Date: Sun, 15 Jun 2003 23:06:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
   Anybody has experienced with MPC755 L2 Cache data parity error?
We use XPC755B Rev. E at 400M Hz, and 1M L2 Cache at 200M Hz.
After the Linux is up and with busy disk accessing or network
operations for several hours, 755 will receive L2 Cache data parity checking
error machine check. If we don't enable L2 Cache data parity checking,
the system will still crash for some time silently. But if we don't enable
L2 Cache, this problem won't occur. Reduce the L2 Cache freq to
160M Hz, 133M Hz or even less won't avoid this problem. It seems
the system will be some more stable(still has problem) if we set the L2
Cache
size to 512k or 256k, but don't know why. We use both the PBGA and
CBGA packages, seems CBGA version are some more stable(still has problem),
don't know why too.
   It's more strange that I can simply let the error occur under Linux with
continuous file copying in ram disk. But I can't let it occur under PPCBoot
with whatever memory operations for even one time, whether use the L2 Cache
memory as L2 Cache or as private memory. The L2 Cache has the same setting
in the above two circumstances.
   Any ideas and suggestions? Thanks.

Shenrong


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
