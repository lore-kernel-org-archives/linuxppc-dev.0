Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id DC8D2DDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:29:17 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so185992uge
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 09:29:16 -0700 (PDT)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: [PATCH] fsl_spi: mode should be "cpu-qe" instead of "qe"
References: <87przwxkzf.fsf@macbook.be.48ers.dk>
	<085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
	<fa686aa40710030857g467a8e13gcee1a19d38e31f9c@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 18:29:09 +0200
In-Reply-To: <fa686aa40710030857g467a8e13gcee1a19d38e31f9c@mail.gmail.com>
	(Grant Likely's message of "Wed\, 3 Oct 2007 09\:57\:35 -0600")
Message-ID: <87zlz0w4a2.fsf_-_@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 >> I think we should update the doc instead of the code here. Thoughts?

 Grant> Updating the doc is more backward compatible.  :-)

Ok.
---

Mode should be "cpu-qe" for QE in CPU mode. "qe" should be reserved
for native QE mode.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Documentation/powerpc/booting-without-of.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ce5d67f..7a6c5f2 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1551,7 +1551,7 @@ platforms are moved over to use the flattened-device-tree model.
    Required properties:
    - device_type : should be "spi".
    - compatible : should be "fsl_spi".
-   - mode : the SPI operation mode, it can be "cpu" or "qe".
+   - mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
    - reg : Offset and length of the register set for the device
    - interrupts : <a b> where a is the interrupt number and b is a
      field that represents an encoding of the sense and level
-- 
1.5.3.2

-- 
Bye, Peter Korsgaard
