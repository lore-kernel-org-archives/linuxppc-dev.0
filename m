Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E909B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 13:22:28 +1100 (EST)
Subject: of_flat_dt_match() helper build FAIL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 13:15:22 +1100
Message-ID: <1295576122.2148.271.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a4f740cf33f7f6c164bbde3c0cdbcc77b0c4997c introduces:

/arch/powerpc/platforms/83xx/mpc831x_rdb.c:63: error: expected '{'
before 'const'

 and more...

This hunk is obviously bogus:

+struct const char *board[] __initdata = {
+	"MPC8313ERDB",
+	"fsl,mpc8315erdb",
+	NULL
+}
+

You should at least compile test your changes :-(

Please send Linus a fix.

Cheers,
Ben.
