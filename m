Message-Id: <4.2.2.20040513093702.05b0bc40@bhawley.mailhost.luminex.com>
Date: Thu, 13 May 2004 09:39:03 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Brian Hawley <bhawley@luminex.com>
Subject: baud rate question
In-Reply-To: <20040513161638.C3444C108D@atlas.denx.de>
References: <Your message of "Thu, 13 May 2004 13:07:25 +0200." <20040513110725.GU4043@smtp.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Forgive the obvious newbie question, but we've tried everything, reviewed
the readme's, etc.

We are using the linux-2.5-ocp tree from bk.

We are using u-boot 1.0.0.

We set u-boot to 38400 in the config.  linux wants to be 9600 by
default.  So, we realize
that we can't see the kernel boot up.

We've tried changing u-boot back to 9600, but haven't been able to.

Is there a way to tell linux to come up at a different baud rate?  We've
tried the earlyserialpk option, and the console options...but no luck.

Thanks for any assistance.

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
