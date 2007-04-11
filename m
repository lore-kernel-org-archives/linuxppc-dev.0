Return-Path: <michaelzwrk@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 109D4DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 03:07:26 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so223735nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 10:07:25 -0700 (PDT)
Message-ID: <1ea6be8e0704111007t2db1432t77823b5cd1f9299b@mail.gmail.com>
Date: Wed, 11 Apr 2007 19:07:25 +0200
From: Michael <michaelzwrk@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: using PCMCIA driver for CF access
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.
I have a CF connected in PC Card ATA compatible IO mode.
It is connected directly to the host local bus.
The CPU is MPC8541 PowerQUICC III.
The kernel is 2.6.14

I'd like to use PCMCIA driver (ide-cs) to access the CF.
I expect to need minimal changes there:
- skipping reading the CIS and performing controller configuration - I
don't need it, I just need the ATA - conformant access.
- There is all the hotplug support thing that I obviously won't use,
but it shouldn't do any harm.

Are those reasonable assumptions, or I'm missing something here?

Thanks a lot,
              Michael
