Subject: Re: No L2 Cache on PReP Machine
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Hager, Johannes, HRD/AB" <johannes.hager@eads.com>
Cc: "PPC Linux Mailing List (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <2D9AB865A49FD511914700105A0EF679016C49C0@morse.smart.lfk.eads.net>
References: 
	 <2D9AB865A49FD511914700105A0EF679016C49C0@morse.smart.lfk.eads.net>
Content-Type: text/plain
Message-Id: <1092905760.10314.71.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Aug 2004 09:56:00 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-19 at 08:43, Hager, Johannes, HRD/AB wrote:

> I am usign Linux on the Motorola MVME3604 Board. This Board complies to the
> PReP standard. So I configured the linux machine type to
> "CHRP/PowerMac/PReP".
> The kernel starts without showing any errors, but the problem is, that the
> L2 cache of the board is not recognized by the kernel. Does the linux not
> support L2 caches on PReP machines or is it another problem?

Generally Linux expects the boot firmware to set up the L2 and L3 caches
on PowerPC machines. Are you quite sure (from benchmark timings) that
the L2 cache is not working? The MVME3604 has an L2 cache outside the
processor, and it should work transparently.

- Adrian Cox
Humboldt Solutions Ltd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
