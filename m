Date: Thu, 10 Aug 2000 11:17:30 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linuxflash
Message-ID: <Pine.LNX.4.21.0008101054140.9899-101000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="854950230-1994791840-965920650=:9899"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--854950230-1994791840-965920650=:9899
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

I'm posting a modified version of Linuxflash. This program is used to
program onboard flash on PPC based embedded boards.

I believe that the original version was written by somebody on this list
(Dan Malek?) and then heavily modified. Since I cannot find any references
to Linuxflash on http://lists.linuxppc.org/lists/linuxppc-embedded/ and
http://freshmeat.net/ I'm posting it here in the hope to find the
original maintainer.

If anybody can give me the original version I could review the
modifications and post a diff with only "progressive" changes.

The problems fixed by me:

1) The size of flash is not taken from a table. Memory is allocated to the
boundary where the firmware begins. This way, you can program as much as
you want as long as the flash is there and you don't overwrite the
firmware.

2) Much more sanity checks. No attempts are made to recover from hardware
problems. Any suspicious behaviour causes error message and immediate
exit.

3) Added support for L800BB90VC chips.

4) Most error messages modified to be more informative.

5) Fixed all compiler warnings.

To sum up, the old version would often fail silently or give useless error
messages like "Unknown Flash Type -2".

I'm not sure if Linuxflash is the right name. Porting to NetBSD should be
trivial. I'll be grateful if anybody gives me pointers to any existing
software for programming flash.

Regards,
Pavel Roskin

--854950230-1994791840-965920650=:9899
Content-Type: APPLICATION/octet-stream; name="linuxflash.tar.gz"
Content-ID: <Pine.LNX.4.21.0008101117300.9899@sunapee.transcept.com>
Content-Description: 
Content-Disposition: attachment; filename="linuxflash.tar.gz"
Content-Transfer-Encoding: BASE64

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
BhpooIEGGmiggQYaaKCBvzH8Hwr7ICMAUAAA
--854950230-1994791840-965920650=:9899--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
