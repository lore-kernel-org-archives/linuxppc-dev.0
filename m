From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 13:13:02 -0700
To: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030304201302.GA4683@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E64FD53.3030107@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 07:24:03PM +0000, Dan Malek wrote:
> Dale Farnsworth wrote:
>
> >arch/ppc/boot/common/relocate.S starts the kernel at address 0
> >which fails if you have a second cpu running at secondary_hold.
> >(The code at secondary hold writes the cpu id at address 4.)
>
> Ummm....are you _sure_ this patch works for all possible boards
> that use this bootloader file?  We've been jumping everyone to
> location zero for a long time.

No, I wasn't sure.  Now after some more looking, I'm sure that
it *won't* work for 40x, 44x, and 8xx.

I'll find another way.

Thanks,
-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
