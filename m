Message-ID: <3EC49CB0.7050202@elsoft.ch>
Date: Fri, 16 May 2003 10:09:20 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH] floppy.h
Content-Type: multipart/mixed;
 boundary="------------030808030303050700030607"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030808030303050700030607
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

 - cosmetic changes for fb_outb macro (paramters are in the wrong order)
 - define fd_cacheflush macro if CONFIG_NOT_COHERENT_CACHE is set

Dave

--------------030808030303050700030607
Content-Type: application/octet-stream;
 name="floppy.h.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="floppy.h.patch.bz2"

QlpoOTFBWSZTWZ/BhXoAAJdfgGZwWH/8km/n/iS/7/+0QAH6rrsBDJGoKbEg2hMTTPSJhGCM
TQ2ImQBGqMoZhMpoAAAAAA0AAA00ojQAAZDQNAAANAAaAJJAmp5U8TU9INTJhAGj0AAm0j1N
D0kJpxSoRQhEhSHwqZww87tYDRO5l5kOF0yipaRJwCAlWkdKkDdfFQPdVxan44evs9N2fUri
knOZpIWWZ9uGXZbEUoJ6qCnDyCSIFT22GKUBJKzSMj6sBV1s40DwWarVcQiMHjsfi+3aUSSM
KHxXiRIhzLhaN1eg8T3YYC4eM6R0HC4t2ndMgcOHwfMiTUsZj2jGDcwrMPqAwMFk655+LAlt
IKGGfXAlOBcBfQw0NjpoaBDHwUl6kMal076YoynnFAQLhfQBAcCEHSoOGNF+YkkciQZ50DKZ
MxqWDUZasL4T6/iMMfMPsOXJ6QgyaB0ph+hLw/oww3Kpca7Q61hknUZjXeB2rdTginGiszSk
SWlfwFOfozWDg3GNpZp2AmPVMQWsDToxKEQUC2v+ZneRZQtNZRIvBfnOnvMNKsPaqfLC7Lyb
BsboLGIFgqqvCBJF71nB5FSSiGyhmQqYg43Eb4s1QtMoygt7fGXkvVFYo9gri9ZOC8UJilxw
DLhOo64zKhslEzNc4eYkwqSt27VnYNRAKPHEUdZSyY1rQSwr+LuSKcKEhP4MK9A=
--------------030808030303050700030607--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
