Message-ID: <407C0738.2030904@lucent.com>
Date: Tue, 13 Apr 2004 09:28:56 -0600
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Xilinx ML300 u-boot question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anybody know what parameters I should use to
load u-boot, using u-boot.    That's right, I want to
build a generic u-boot that goes on the Microdrive of
a Xilinx ML300 development board.  I have several of them
to manage.  I want the generic u-boot to go and download
a machine-specific u-boot that I can change on my workstation
without having to write it to the microdrive.

Or can I just have u-boot start the kernel with no parameters
and have all the initial args for the kernel built into the
kernel?

-mike wellington
  wellington@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
