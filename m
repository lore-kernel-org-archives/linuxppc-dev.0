Subject: Re: Writing in virtual memory space failed
From: Thomas RIVIERE <thomas.riviere@com2gether.net>
To: Thomas RIVIERE <thomas.riviere@com2gether.net>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1062063390.17263.1304.camel@pcl1.com2gether-corp.net>
References: <1062063390.17263.1304.camel@pcl1.com2gether-corp.net>
Content-Type: text/plain
Date: 28 Aug 2003 14:26:55 +0200
Message-Id: <1062073616.1155.1314.camel@pcl1.com2gether-corp.net>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jeu 28/08/2003 11:36, Thomas RIVIERE wrote :

  Hi all,

  I m trying to boot linux-2.4.21 kernel on a custom board with MPC852T
  proc.I use zImage.embedded and it hangs after "Now booting the kernel".

Problem fixed, I corrupted a definition in mmu.h.
Sorry for the disturbing.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
