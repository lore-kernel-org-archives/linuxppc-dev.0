Return-Path: <xiaogeng.jin@gmail.com>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id D519FB7CD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 12:16:31 +1100 (EST)
Received: by gxk9 with SMTP id 9so798181gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 17:16:29 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 19 Feb 2010 17:16:29 -0800
Message-ID: <5bbdacc81002191716q4929f72ao30215859bd080465@mail.gmail.com>
Subject: hrtimers in powerpc arch?
From: Xiaogeng Jin <xiaogeng.jin@gmail.com>
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

Is hrtimers supported in the powerpc arch and used in embedded powerpc
drivers? I greped ktime_t and hrtimer_start() under arch/powerpc and
found not two many calls. Does it indicate the powerpc world doesn't
use hrtimers?

Thanks,
-Ryan.
