Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 938F1DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 09:50:33 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so831723uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 14:50:30 -0800 (PST)
Message-ID: <478A967E.7080201@genesi-usa.com>
Date: Sun, 13 Jan 2008 22:53:50 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: I2C and CAN bus on MPC5200B device tree
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


Hi guys,

I know the I2C stuff is up in the air (I cannot pinpoint the documentation
for it) and have not found any CAN bus documentation for device trees.

I want to update the firmware tree to add these but, am basically looking
for those docs, or someone to go over a few points.. is there some kind of
tree standard I should be looking at, or some patch I missed which has
a driver which implements something that looks at a compatible tree?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
