From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling apache for Linux PPC
Date: Sat, 5 Aug 2000 09:45:23 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJEEBPCBAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to implement embedded linux router.

So I tried to cross-compile apache on x86 linux machine.

I changed the compiler name from 'gcc' to 'powerpc-linux-gcc'

But when I ran make there was an error. Of course compile with gcc, it works well.

Is there any options? It seems there is no use of configure option '--tartget=powerpc-linux'

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
