Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 472FF679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 02:51:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so20880pyf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 09:51:47 -0700 (PDT)
Message-ID: <b4b98b690605160951o5cefddd8t6b19a91a708f0431@mail.gmail.com>
Date: Tue, 16 May 2006 09:51:46 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: what does this mean?
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

My code is hitting in sched.c ->

=09if (unlikely(in_interrupt())) {
=09=09printk("Scheduling in interrupt\n");
=09=09BUG();
=09}
It is hitting this printk.  So is this telling me I'm calling schedule
from within an interrupt?  How can this be?  Has anyone else seen
something like this and can anyone give me a hint as to what to look
for.

Thanks.
-stv
