Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 953BCDDDA7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 09:24:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 2.6.27.6 kernel Bad trap boot problem on MPC8568E
Date: Tue, 10 Feb 2009 17:24:13 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C07525@CYBORG3.cyclone.com>
In-Reply-To: <4991F808.9090001@freescale.com>
References: <43EB80E07C42E1408726E4905FB96B04C07522@CYBORG3.cyclone.com>
	<4991F808.9090001@freescale.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Scott

> That's an SPE Unavailable exception.  Try enabling CONFIG_SPE.

That was the problem.  Thanks for your help.

Scott
