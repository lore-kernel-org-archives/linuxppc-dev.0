Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: AMD flash error
Date: Thu, 22 Jan 2004 10:00:10 +0530
MIME-Version: 1.0
Message-Id: <200401221000.10453.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using AMD flash on the target and I am getting
"Chip not ready after erase suspended" error.

Is there any known  flash driver bug in
linux 2.4.20 (denx) kernel?

Any help is will be appreciated.

Regards,
S. Hebbar.

Linux boot log:
============

Physically mapped flash: Found 2 x16 devices at 0x0 in 32-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
Physically mapped flash: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Using tn100_map partition definition

====================

Error dislay:

Chip not ready after erase suspended: status = 0xffffffff
Write of %zd bytes at 0x00001044 failed. returned 582240, retlen %zd
Not marking the space at 0x0008e260 as dirty because the flash driver returned
r
etlen zero
Chip not ready after erase suspended: status = 0xffffffff
Write of %zd bytes at 0x00001044 failed. returned 582240, retlen %zd
Not marking the space at 0x0008e260 as dirty because the flash driver returned
r
etlen zero
cp: write: Input/output error


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
