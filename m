Date: Tue, 8 Apr 2003 17:24:21 -0700
From: Matt Porter <porter@cox.net>
To: Binh Nguyen <binh@us.ibm.com>,
	linuxppc-embedded@lists.linuxppc.org,
	linuxppc-users@lists.linuxppc.org
Subject: Re: Ethernet Driver Needed for IBM PPC 405 (Codename Walnut)
Message-ID: <20030408172421.A22476@home.com>
References: <OFA4C6E054.A1AC76DA-ON87256D02.00711FB1@us.ibm.com> <20030408233356.GC13256@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030408233356.GC13256@zax>; from david@gibson.dropbear.id.au on Wed, Apr 09, 2003 at 09:33:56AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 09, 2003 at 09:33:56AM +1000, David Gibson wrote:
>
> On Tue, Apr 08, 2003 at 04:45:47PM -0400, Binh Nguyen wrote:
> >
> > I heard that some one has written an ethernet driver for the IBM PPC 405
> > board for Linux some time ago.  The author  has seen  performance
> > improvement because the driver services interrupts in a better way.  If
> > some one has a copy of the driver, would you please send it to
> > binh@us.ibm.com.  Also any tips on how to install the driver is
> > appreciated.  Thanks very much.
>
> The driver is included in the linuxppc_2_4_devel and linuxppc-2.4
> kernel trees.  You probably want to be using one of those trees in any
> case.

He might be referring to a post here (in the last 6 months or so)
where the poster mentioned writing a replacement EMAC driver that
had better performance than the standard driver.  I can't seem to
locate the post at the moment, but perhaps somebody else remembers
and can find it in the archives.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
