Message-ID: <F26BB04303A9C849B00EE0852025E9F304C0C3@rcdell.rcnets.com>
From: "Perri, Joe" <jperri@viadux.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Network performance loss when migrating to 2.4.18 on Walnut 405GP
Date: Tue, 4 Mar 2003 13:18:07 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On the IBM Walnut platform, using MontaVista Linux with 2.4.2 kernel, the
box can
route 10,000+ packets per second (pps) full-duplex continuously between the
405 on-board Ethernet port and an Intel 82559 PCI Ethernet card (500 byte
packets).

With a similarly-configured 2.4.18 kernel, performance drops to ~6500 pps.

Both Ethernet drivers are correctly calling consistent_sync(), so I don't
believe
it's a cache flushing issue. Using the 2.4.2 Ethernet drivers with 2.4.18
does
not improve the performance, so I don't believe it's a driver issue.

I'm at somewhat of a loss to explain such a large performance difference.
Could the network stack have changed enough between 2.4.2 and 2.4.18
to cause this?

MontaVista is "investigating", but I am wondering
if any list members have run into this?

Thanks for any information.

Note: Testing was done with Smartbits.

Joe Perri
Senior Software Engineer
> Viadux, Inc.
> 9890 Towne Centre Drive, Suite 200
> San Diego, CA 92121
> 858-678-1634
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
