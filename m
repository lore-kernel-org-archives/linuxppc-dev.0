Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 6609FDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 04:28:14 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so451187yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 11:28:12 -0700 (PDT)
Message-ID: <9e4733910807221128h4a425c37qd9a86e8d9458d005@mail.gmail.com>
Date: Tue, 22 Jul 2008 14:28:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/3] ALSA SoC: Add mpc5200-psc I2S driver
In-Reply-To: <20080722065358.7306.9412.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065358.7306.9412.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What about the mpc5200b?

+/* Match table for of_platform binding */
+static struct of_device_id psc_i2s_match[] __devinitdata = {
+       { .compatible = "fsl,mpc5200-psc-i2s", },
+       {}
+};
+MODULE_DEVICE_TABLE(of, psc_i2s_match);
+

I'm just being grumpy because updating to linus/master made me fix
over a hundred merge conflicts, now I have to test everything again.

-- 
Jon Smirl
jonsmirl@gmail.com
