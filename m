Message-ID: <387BC7FD.5AACAFD0@jlc.net>
Date: Tue, 11 Jan 2000 19:17:01 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Dan Malek <dan@netx4.com>, Cort Dougan <cort@fsmlabs.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.3.37 / 2.3.18 / 2.2.13
References: <20000107213528.A29581@mail.ro.nu> <387A38DB.8C51AB1D@netx4.com> <20000110211045.F8416@mail.ro.nu> <387A5FD5.33A21291@netx4.com> <kfyn1qc770o.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Speaking of updating and 2.2, 8xx support were broken in 2.2.14 because
> of changes in kernel/head.S.


The 8xx support in the 2.2.xx tree is very, very old, and I would
be surprised if it ran on anything.  Once I get 2.3.xx up to date,
I will attempt to update 2.2.xx.

The only 2.2.xx software for the 8xx is the tarball on ppc.kernel.org.


> Also, is there any reason why not at least the 8xx-only code in 2.2.15
> could be updated to working versions?


My time to make it happen, and to be able to do make substantial
changes to the code......In the past my timing was such that the
tree was in the process of syncing with Linus, so the updates were
put "on hold".


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
