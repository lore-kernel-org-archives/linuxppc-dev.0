Return-Path: <pppeterpppan@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by ozlabs.org (Postfix) with ESMTP id 79F42B7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 13:08:12 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 5so142584qwf.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 18:08:10 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 26 Feb 2010 10:08:09 +0800
Message-ID: <48abf2c21002251808v4d40ea42s869b1307dfc3817@mail.gmail.com>
Subject: Does Linux 2.6.32 support NAND flash connect with MPC8247 through
	localbus with GPCM mode?
From: Peter Pan <pppeterpppan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm recently porting Linux 2.6.32 to our custom board with MPC8247. We have a
NAND flash connected using GPCM mode of local bus. But after I search
through the Linux
source, there is no compatible like "fsl,gpcm-nand". And I can not
find any driver
that seems works for our scene.

Does Linux 2.6.32 has the support for such nand device or I need to
construct my own
NAND driver using generic platform NAND driver?
