Return-Path: <rayan@nucleodyne.com>
Received: from easyspace2.ezspl.net (easyspace2.ezspl.net [66.45.254.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79443B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Feb 2010 17:33:25 +1100 (EST)
Received: from mail-yx0-f187.google.com ([209.85.210.187])
	by easyspace2.ezspl.net with esmtpsa (TLSv1:RC4-MD5:128) (Exim 4.69)
	(envelope-from <rayan@nucleodyne.com>) id 1Nhzww-000209-QO
	for linuxppc-dev@lists.ozlabs.org; Thu, 18 Feb 2010 01:33:22 -0500
Received: by yxe17 with SMTP id 17so7146757yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 22:33:18 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 17 Feb 2010 22:33:15 -0800
Message-ID: <5bbdacc81002172233x64a05ae2m4ecdbddf85dac8c0@mail.gmail.com>
Subject: State of PREEMPT_RT in PPC arch
From: Ryan <rayan@nucleodyne.com>
To: ppcdev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We have a MPC7448 based board with 2.6.21 ported (ppc arch). We want
to apply the PREEPMT_RT patch to the existing kernel and drivers.
Well, it turns out to be a difficult task since the ppc arch doesn't
seem to support the RT patch very well. Has anyone had a working
2.6.21+ kernel with RT patch for the ppc arch? Is the ppc arch just
dying?

I may have two choices. One is to move to the powerpc arch that is
actively developed and has proven working RT patches from the
community. This will force us to migrate our drivers to a newer kernel
and a new arch, which is certainly not trivial. The other is to back
port an existing and working RT patch to the ppc arch of 2.6.21,
which, at least for now, seems quite difficult and may not be merited
for future.

I'm soliciting comments from the community. Thanks in advance for
sharing your thoughts.

-Ryan.
