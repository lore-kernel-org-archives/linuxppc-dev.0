Return-Path: <johnny.hacking@gmail.com>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 9C57EB70C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 13:50:09 +1000 (EST)
Received: by yxe33 with SMTP id 33so480874yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 20:50:07 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Jun 2009 11:50:06 +0800
Message-ID: <cb9ecdfa0906232050n6fcfee31ubeee4bcd9b8c0dfe@mail.gmail.com>
Subject: How the kernel printk works before do console_setup.
From: Johnny Hung <johnny.hacking@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-embedded@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All:
    I have a powerpc arch platform. The default console is ttyS1 not
ttyS0 in the platform. My question is how the kernel print debug
message
like DBG before parse kernel command line and do console_setup
function. The command line passed to kernel about console info is
console=ttyS1.
So kernel can not print anything before parse cmd line and initial
console but the result is against. Anyone point me or give me a clue
is appreciate.

BR, H. Johnny
