From: "Navin Boppuri" <nboppuri@myiagent.com>
To: "Kirk Haderlie" <khaderlie@vividimage.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FADS 823
Date: Wed, 14 Jun 2000 14:30:20 +0100
Message-ID: <NEBBLLEGJMLHPJEFEOKPAEBOCAAA.nboppuri@myiagent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <319E391E2049D311843500609457383D07FC51@exchange.vividimage.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The 8xxrom-0.3.0 source which I downloaded from you site has errors.
Especially, the fads.h file is corrupt. The structure defined for the board
info is incorrect. The '#ifndef __ASSEMBLY__' is missing which gives you
errors in compilation.  I corrected that error but I still am getting a
bunch of erros.

Does someone have an original source of the 8xxrom-0.3.0 code with support
for the fads board? Please help. I need this boot code real bad.

Thank you.
Navin.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
