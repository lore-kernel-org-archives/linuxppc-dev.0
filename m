Return-Path: <Dag.K.Rognlien@sintef.no>
Received: from smtpb.sintef.no (smtpb.sintef.no [129.241.253.24])
	by ozlabs.org (Postfix) with ESMTP id 213CDDDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 02:24:21 +1100 (EST)
Received: from sintefav1.sintef.no (sintefav1.sintef.no [129.241.253.14])
	by smtpb.sintef.no (Postfix) with ESMTP id 535F37240F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 16:24:18 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: Re:[PATCH] Fix wrapper platform for adder875, and
	combine
Date: Tue, 26 Feb 2008 16:20:49 +0100
Message-ID: <39417DF3286A66428FA558987839F44F03FC919A@SINTEFXCH01.sintef.no>
In-Reply-To: <mailman.679.1203532411.17968.linuxppc-dev@ozlabs.org>
References: <mailman.679.1203532411.17968.linuxppc-dev@ozlabs.org>
From: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
To: linuxppc-dev@ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch from the 20th of February has not been taken into the latest
powerpc.git

Mvh,
Dag Rognlien=20


Date: Wed, 20 Feb 2008 12:33:38 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] Fix wrapper platform for adder875, and combine
	defconfigs.
To: galak@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
Message-ID: <20080220183338.GA9282@loki.buserror.net>
Content-Type: text/plain; charset=3Dus-ascii

This fixes the following bug:
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051979.html

Separate defconfigs are no longer needed now that CONFIG_DEVICE_TREE is
gone.

Signed-off-by: Scott Wood <scottwood@freescale.com>
