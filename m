From: Philip.Lougher@Zarlink.Com
Subject: reading block of data from host problem!!!!
To: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF24FA1E60.A88890F1-ON80256CE0.005FD9DA@zarlink.com>
Date: Wed, 5 Mar 2003 17:33:34 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Hello All,
>    can any body tell what is the problem, it just hangs in reading the
>"block 1" of zImage.treeboot and not proceeding further from tftp
>booting process. I am using IBM power pc redwood 4.
>thanking you
>franklin

As usual, you need to give more information, otherwise it's anyone's guess
what's happening.

In this case, is the board hanging trying to read the first block, or has
it hung *after* reading the first block?

If it's trying to read the first block, then you've got a network
configuration problem.  Use tcpdump on the ethernet link to see what (if
any) traffic is going between the host and server.

If it's crashed after reading the first block, the first block download
probably over-wrote some bootloader critical information.  Try moving the
download address of the image.

Phillip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
