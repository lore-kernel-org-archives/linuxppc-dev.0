Subject: Re: Ethernet Driver Needed for IBM PPC 405 (Codename Walnut)
To: linuxppc-embedded@lists.linuxppc.org
Cc: porter@cox.net, david@gibson.dropbear.id.au
Message-ID: <OFB63A35B3.511F2807-ON87256D03.0047DEBC-85256D03.0048F8E2@us.ibm.com>
From: Binh Nguyen <binh@us.ibm.com>
Date: Wed, 9 Apr 2003 09:10:48 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I heard that some one has written an ethernet driver for the IBM PPC
405
> > board for Linux some time ago.  The author  has seen  performance
> > improvement because the driver services interrupts in a better way.  If
> > some one has a copy of the driver, would you please send it to
> > binh@us.ibm.com.  Also any tips on how to install the driver is
> > appreciated.  Thanks very much.

Some clarifications to the origional posting:  I am refering to a post
where the poster mentioned writing a replacement EMAC driver that had
produced better performance than the standard one shippped with MontaVista
Linux.

Binh Nguyen




                      Matt Porter
                      <porter@cox.net>         To:       Binh Nguyen/Raleigh/IBM@IBMUS,
                                                linuxppc-embedded@lists.linuxppc.org,
                      04/08/03 08:24 PM         linuxppc-users@lists.linuxppc.org
                                               cc:
                                               Subject:  Re: Ethernet Driver Needed for IBM PPC 405
                                                (Codename Walnut)






On Wed, Apr 09, 2003 at 09:33:56AM +1000, David Gibson wrote:
>
> On Tue, Apr 08, 2003 at 04:45:47PM -0400, Binh Nguyen wrote:
> >
> > I heard that some one has written an ethernet driver for the IBM PPC
405
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
