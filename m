Date: Sun, 27 Aug 2000 16:28:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: status note: 2.4.0-test6 paulus on 7200
Message-ID: <20000827162808.C19122@opus.bloom.county>
References: <398E9829.714A608@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <398E9829.714A608@pop.agri.ch>; from toa@pop.agri.ch on Mon, Aug 07, 2000 at 01:06:17PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 07, 2000 at 01:06:17PM +0200, Andreas Tobler wrote:

> a short status note, the 7200 boots again with the latest linux-pmac-devel. It
> took a long time, but finally it works again. Thanks to all who helped.
> One thing I have, although. My 7200 doesn't use the internal SCSI bus nor the
> external. I use a 2940UW to boot from. But this device gets only recognized when
> I apply the attached patch. From Geert.
> So, I don't know who to contact to comment this patch. (Well, I actually know
> who, but I get few to no responses)

This doesn't work for me with 2.4.0-test7 (todays BK).  I now get failed to
allocate resource {0,1} for device Adaptec-7881U and then aic7xxx fails to
active the device due to a pci resource conflict.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
