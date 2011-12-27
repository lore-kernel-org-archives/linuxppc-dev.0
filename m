Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5367B6FF1
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2011 07:02:58 +1100 (EST)
Received: from bzq-79-181-238-16.red.bezeqint.net ([79.181.238.16]:32980
 helo=felix.lan) by sh78.surpasshosting.com with esmtpa (Exim 4.69)
 (envelope-from <felix@embedded-sol.com>) id 1Rfcpl-0003jl-AZ
 for linuxppc-dev@ozlabs.org; Tue, 27 Dec 2011 14:37:13 -0500
Message-ID: <4EFA1E70.6020203@embedded-sol.com>
Date: Tue, 27 Dec 2011 21:37:20 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: NAND or other high density storage on MPC8260
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On a custom board based on MPC8260 I have to replace end-of-life
2GB Sandisk mDoc H3 by other storage device of comparable density.
The most natural choice seems to be NAND connected to UPM.
However FSL UPM NAND driver in mainline does not support MPC82xx.
I have several questions in this regard:

1. How difficult would be to modify mainline UPM NAND driver to work
     on MPC8260 ?
2. What other options are feasible and cost effective? I was thinking 
about
     SPI NOR and Compact Flash on UPM.

Thanks.

Felix.
