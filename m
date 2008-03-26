Return-Path: <neko@genesi-usa.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id AED2ADE555
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 03:15:15 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1839877nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:15:13 -0700 (PDT)
Message-ID: <47EA7687.5000102@genesi-usa.com>
Date: Wed, 26 Mar 2008 16:15:03 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Missing patch for MPC5200B register definitions?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've just been looking into the MPC5200B AC97 driver breakage with the
latest Git kernel, and found the following patch;

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035952.html

Is not in the latest tree. As such anything which uses the new MPC5200B
registers (especially important on AC97 and probably not used otherwise)
has not or was not applied.

Since the latest kernel source from git actually includes the MPC5121E
differences, I assume this is a regression?

How do we go about fixing this?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
