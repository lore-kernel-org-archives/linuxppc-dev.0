Message-Id: <5.1.0.14.2.20030224095828.03022e38@mail.ebshome.net>
Date: Mon, 24 Feb 2003 10:02:55 -0800
To: brian.auld@adic.com
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: Kernel Preemption patch
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <995FF289C9D69747A09E42992644595405B23685@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:56 AM 2/24/2003, brian.auld@adic.com wrote:
>However, I noticed that your 'preempt_enable' at the bottom of the exerp has
>been changed from 'preempt_enable' as in the RML patch, to
>'preempt_enable_no_reshed'. What's the reason for this inconsistency?


Well, as I said I don't use RML patch. This code is from MVL.
Frankly, I don't think that this particular change is very important (maybe
it is :).
I didn't notice any difference between these two versions.

It's "if !defined(CONFIG_4xx) || defined(CONFIG_440)" which is more
important :)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
