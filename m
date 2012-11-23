Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9473E2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 13:22:57 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id qAN2MrbK012844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2012 20:22:54 -0600
Message-ID: <1353637373.17856.58.camel@pasglop>
Subject: [Fwd: [PATCH] From: Gavin Shan <shangw@linux.vnet.ibm.com>]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 23 Nov 2012 13:22:53 +1100
Content-Type: multipart/mixed; boundary="=-b7q9/kK4tWJvVZBMqGEg"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-b7q9/kK4tWJvVZBMqGEg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-b7q9/kK4tWJvVZBMqGEg
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [PATCH] From:
 Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: message/rfc822

Return-Path: <aik@ozlabs.ru>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0
 tests=AWL,BAYES_00,FORGED_RCVD_HELO autolearn=ham version=3.1.9
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182]) by gate.crashing.org (8.14.1/8.13.8) with ESMTP id
 qAM6utVN030467 for <benh@kernel.crashing.org>; Thu, 22 Nov 2012 00:56:57
 -0600
Received: by mail-ie0-f182.google.com with SMTP id s9so5009372iec.41 for
 <benh@kernel.crashing.org>; Wed, 21 Nov 2012 22:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20120113;
 h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
 bh=RZF8KRL50Od5TU2ICIVggYHIb7E+2SpiA5/1pSGHnec=;
 b=JhGoMTyOKwDN0N6d3B2w2UETbGDAqW9nUwbOh3xNkta2QCbW4sijScY2jsCATpShxm
 /ndV8J/TsarZ5GGLn5fGHqi0dyN6aV31jnAMQPCduzQIZ7hqsGp2Cyk//hIvN2KNhifl
 P6MgleKzUjO39U7GZXccTTZU8yJcJXiHssfXc/Gv+P769qj9NQQLD/NVv4Y66UDez5Im
 K8qauUE0WTk09Sbb2PUopFS7wifkk/rObn5LctGdhEs2aD33xu0nJp2RGbYVHYS/VsGq
 S8g8sUhiA08CiTj1IXORKjq/GKeev7VBy+NdOfDpYSG/VtKahgH2af3awVylZA6lbL4q nebw==
Received: by 10.42.139.74 with SMTP id f10mr19420363icu.4.1353567414229;
 Wed, 21 Nov 2012 22:56:54 -0800 (PST)
Received: from ka1.ozlabs.ibm.com (ibmaus65.lnk.telstra.net.
 [165.228.126.9]) by mx.google.com with ESMTPS id
 i9sm1573749igl.9.2012.11.21.22.56.50 (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 21 Nov 2012 22:56:52 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH] From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 22 Nov 2012 17:56:28 +1100
Message-Id: <1353567388-32739-1-git-send-email-aik@ozlabs.ru>
X-Mailer: git-send-email 1.7.10.4
X-Gm-Message-State: ALoCoQlv1Gkc8VRn4zY5QK1MeiALwgrPUb3nBy5u7+sdhOl2PEvnzegzcwHMorAY6o9YOMZ5iEdV
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

pseries msi: fixed crash on PCI devices without EEH capability

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index d19f497..e5b0847 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -220,7 +220,8 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 
 	/* Get the top level device in the PE */
 	edev = of_node_to_eeh_dev(dn);
-	edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
+	if (edev->pe)
+		edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
 	dn = eeh_dev_to_of_node(edev);
 	if (!dn)
 		return NULL;
-- 
1.7.10.4

--=-b7q9/kK4tWJvVZBMqGEg--
