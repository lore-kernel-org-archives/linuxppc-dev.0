Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id D9AFCDE6A0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 07:07:41 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2936722rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 14:07:39 -0700 (PDT)
Message-ID: <4b73d43f0807091407w31280a43tbd07ec8a1aca1a93@mail.gmail.com>
Date: Wed, 9 Jul 2008 15:07:39 -0600
From: "John Rigby" <jrigby@freescale.com>
Sender: jcrigby@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Two pci patches that are prereq's for MPC5121 pci
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: jcrigby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Could you pick up these two powerpc pci patches.  Grant Likely ack'd
them both. No one nak'd them.

powerpc: pci config cleanup [rev2]
http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19299

powerpc: Move mpc83xx_add_bridge to fsl_pci.c [rev2]
http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19300

Thanks
John
