Date: Mon, 8 Sep 2003 16:26:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: virt_to_phys() on 440
Message-ID: <20030908162629.B16761@home.com>
References: <20030908151459.A16761@home.com> <20030908223649.948.qmail@web40905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030908223649.948.qmail@web40905.mail.yahoo.com>; from bkuschak@yahoo.com on Mon, Sep 08, 2003 at 03:36:49PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 08, 2003 at 03:36:49PM -0700, Brian Kuschak wrote:
>
> > These APIs are valid only for
> > system
> > memory kernel addresses that are staticly mapped.
> >
> > Anything wanting a generic translation from
> > virt->phys should
> > call iopa() directly until somebody drives a generic
> > translation
> > API into the kernel.
>
> Thanks, I missed that.

BTW, it was pointed out to me that the changesets I made to linux-2.4
to merge the 2.6 virt_to_* method have been merged back into current
linuxppc-2.4 and linuxppc_2_4_devel.

So, all current devel trees have the API correct implementation now.

Now somebody needs to create a nice device-to-device DMA and bus
address translation API. :)

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
