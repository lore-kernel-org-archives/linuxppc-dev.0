Message-Id: <200404220843.DAA10024@lists.linuxppc.org>
Date: Thu, 22 Apr 2004 16:44:34 +0800
From: "=?utf-8?B?amVmZnk=?=" <leo_guo@jisung.cn>
To: "=?utf-8?B?bGludXhwcGMtZW1iZWRkZWRAbGlzdHMubGludXhwcGM=?=" <linuxppc-embedded@lists.linuxppc.org>
Cc: "=?utf-8?B?V29sZmdhbmcgRGVuaw==?=" <wd@denx.de>
Subject: =?utf-8?B?UmU6IFJlOiB3aGljaCBpcyB0aGUgYmVzdCByb290IEZpbGUgc3lzdGVtIGluIGVtYmVkIGxpbnV4IHN5c3RlbT8=?=
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Because our board will be turned on and off frequently, so I think "high
stability" is the important, and a R/W file system is prefer selection
too! Another performances such as speed of booting is not the focus!

Now our system can runs ok, I use EXT2 FS as the root file system build
in a 32M DOC2000, but it seems it's unstable! In any time when the linux
is starting, you turn off the power, maybe the root file system will
crash!

I have serval questions want to be confirmed:
1. Whether the DOC2000 is unstable?
2. Can I build a EXT2 FS in flash?
3. How to avoid the file system crash in embed linux system?

Thanks!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
