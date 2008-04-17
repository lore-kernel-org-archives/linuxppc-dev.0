Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C069DE13D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 17:14:21 +1000 (EST)
Message-Id: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: build breakage from of i2c helper patch
Date: Thu, 17 Apr 2008 02:11:41 -0500
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Linux I2C <i2c@lm-sensors.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm guessing the "[POWERPC] i2c: OF helpers for the i2c API"

http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commitdiff;h=612212a3f2f053ea68ce9cd16d3deeca7754e8c9

is causing this build failure:

http://kisskb.ellerman.id.au/kisskb/buildresult/24375/

- k
