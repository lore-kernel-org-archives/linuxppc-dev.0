Return-Path: <cjb@laptop.org>
Received: from void.printf.net (void.printf.net [89.145.121.20])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 789F52C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2012 22:36:12 +1000 (EST)
From: Chris Ball <cjb@laptop.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
 <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net>
 <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org>
Date: Mon, 17 Sep 2012 08:36:16 -0400
In-Reply-To: <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org> (Kumar
 Gala's message of "Thu, 13 Sep 2012 07:47:33 -0500")
Message-ID: <m3k3vsn7wf.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Huang Changming-R66093 <R66093@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Sep 13 2012, Kumar Gala wrote:
>>> Can you list out which SoCs support it and which don't.  Having this list
>>> will be useful in understanding which controller versions supported it.
>>> 
>> P1020, p1021, p1022, p1024, p1015 and p4080 can't support it.
>> Mpc8536, p2020, and the other current DPAA silicon (e.g. p5020, p3041) support it.
>
> Based on this, why don't we use the HOSTVER register to detect instead of device tree:

I've got a mild preference for handling quirk assignment in the DT
rather than in driver code, so I'd prefer to just push the original
patch to mmc-next as-is.  Does that sound okay?

(I think the argument that there isn't going to be any new hardware
with this problem is equally in favor of both methods.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
