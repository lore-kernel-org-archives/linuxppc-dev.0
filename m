Message-ID: <3D9871CE.7010607@mrsl.com>
Date: Mon, 30 Sep 2002 11:46:22 -0400
From: Tim Moloney <moloney@mrsl.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Location for Linux kernel module support files
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have written a device driver (module) that needs a configuration
file.  Where is the standard place to put such files?

I originally put it in the same directory as the .o file but
'depmod -a' complains that it's not an ELF file.

--
Tim Moloney
ManTech Real-time Systems Laboratory
2015 Cattlemen Road                             \     /
Sarasota, FL  34232                     .________\(O)/________.
(941) 377-6775 x208                        '  '  O(.)O  '  '


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
