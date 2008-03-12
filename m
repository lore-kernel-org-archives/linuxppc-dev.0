Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 5FE0EDE1A3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:45:59 +1100 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F11C197B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:42 -0400 (EDT)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
	ESMTP id B817F197A for <linuxppc-dev@ozlabs.org>;
	Wed, 12 Mar 2008 19:45:40 -0400 (EDT)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: maple: minor updates
Date: Wed, 12 Mar 2008 18:43:02 -0500
Message-Id: <1205365385-28315-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please consider the following mostly-trivial patches for 2.6.26.

 arch/powerpc/configs/maple_defconfig |  133 ++++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/maple/pci.c   |   47 ------------
 arch/powerpc/platforms/maple/setup.c |    2 +-
 3 files changed, 129 insertions(+), 53 deletions(-)
