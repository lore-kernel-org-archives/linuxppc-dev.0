Subject: Re: PCI Memory mapping
From: Jeff Angielski <jeff@theptrgroup.com>
To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040316114030.GB7133@smtp.barco.com>
References: <20040316114030.GB7133@smtp.barco.com>
Content-Type: text/plain
Message-Id: <1079455175.4184.25.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 16 Mar 2004 11:39:35 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-03-16 at 06:40, Marc Leeman wrote:
> Any pointers about making cpu memory visible on the pci bus would greatly
> be appreciated.

Check your PPC documentation for the configuration of the PITARx,
PIBARx, and PICMRx.  Once you read about these it should all make sense.

Then look at your bootloader source code (hopefully you are using
u-boot) to see how these registers are being configured.

HTH,
Jeff Angielski
The PTR Group


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
