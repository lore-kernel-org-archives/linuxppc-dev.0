Return-Path: <prodyuth@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 90CD3DE13D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:54:40 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so383736ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 11:54:34 -0700 (PDT)
Message-ID: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
Date: Thu, 3 Jul 2008 11:54:33 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Support for low power mode for powerpc processors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I would like to know whether Linux on PowerPC puts the processor on
low power mode during idle state. Most PowerPC processors support a
low power mode. I am looking to add support for low-power mode in
Linux for AMCC 4xx processors.

My questions are the following:
1) Is tickless kernel integrated into the PowerPC tree?
2) Does Linux kernel puts the processor in low power mode if cpu is
idle, and takes it out of that state on wakeup (triggered by
interrupt/WOL etc)?

Any suggestions/comments would be welcome.

Thanks,
Prodyut
