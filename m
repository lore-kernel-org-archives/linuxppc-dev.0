Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD9CCC3.1030704@oerlikon.ca>
Date: Fri, 26 Oct 2001 16:51:15 -0400
From: Sebastien Ruel <sruel@oerlikon.ca>
Reply-To: sruel@oerlikon.ca
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: looking for a nice root filesystem image
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Finally a got a working system (RPX-CLLF), booting from Flash, with
minimal root filesystem (Thanks to M. Denk).

Now i'm looking for a "a bit bigger" root filesystem with typical
utilities like: umount, ifconfig, etc. that could fit in around 8 MBytes
of Flash. Is there some image available somewhere on the Net?

I have tried to strip down the "target" directory from the Hardhat Linux
CDK 1.2, but it became a nightmare with libraries. PAM security is using
to much disk space, and it's not easy to remove it. My embedded system
does not need all that security.

Thanks

Sebastien Ruel, eng.
Oerlikon Contraves


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
