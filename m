Message-ID: <3E64FD53.3030107@embeddededge.com>
Date: Tue, 04 Mar 2003 14:24:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
References: <20030304191644.GA4524@rover.farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> arch/ppc/boot/common/relocate.S starts the kernel at address 0
> which fails if you have a second cpu running at secondary_hold.
> (The code at secondary hold writes the cpu id at address 4.)

Ummm....are you _sure_ this patch works for all possible boards
that use this bootloader file?  We've been jumping everyone to
location zero for a long time.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
