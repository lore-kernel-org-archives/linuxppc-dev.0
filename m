Date: Tue, 5 Aug 2003 13:48:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] consistent_sync unaligned buffers debug check, resend
Message-ID: <20030805134828.B722@home.com>
References: <5.1.0.14.2.20030804213501.00b08410@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030804213501.00b08410@mail.ebshome.net>; from ebs@ebshome.net on Mon, Aug 04, 2003 at 09:40:02PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 04, 2003 at 09:40:02PM -0700, Eugene Surovegin wrote:
> I suspect original e-mail had bad timing, all important people were busy
> preparing/flying to OLS ;-)

Heh

> So, here is another try...
>
> These patches add new debugging option under "Kernel hacking|Kernel debugging".
> This option enables rate-limited warning print out when consistent_sync is
> called with unaligned buffer.

Looks fine to me.  I'll add it to my large queue of changesets for
Paul to review/pull to marcelo's tree.

FWIW, I talked to a bunch of SCSI folks at OLS about DMA off the stack
and they believe it's all gone in 2.6.  I double-checked and that does
seem to be the case.  Nevertheless, I think we will always be fighting
poorly written drivers so this seems to be a great debug option.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
