Subject: Re: page fault
From: David Woodhouse <dwmw2@infradead.org>
To: bharat <bharat@coraltele.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <18345265.1090641072140.JavaMail.administrator@RnDserver>
References: <1090590567.3939.20.camel@localhost.localdomain>
	 <20820601.1090640061250.JavaMail.administrator@RnDserver>
	 <18345265.1090641072140.JavaMail.administrator@RnDserver>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 13:16:32 -0400
Message-Id: <1090689392.4213.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-07-24 at 09:22 +0530, bharat wrote:
> problem is that it all went ok in kernel space but as soon as it enters
> in user space it starts giving PAGE_FAULTS.

You seem to have posted this in reply to Andreas Oberritter's message in
which he offered a patch to export m8xx_cpm_hostalloc().

Please could you explain why these are related -- did you only start
seeing this problem after you applied his patch?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
