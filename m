Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id CAA54DE055
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Dec 2006 05:02:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Define Linux system memory
Date: Wed, 20 Dec 2006 13:02:28 -0500
Message-ID: <3C02138692C13C4BB675FE7EA2409529261219@bluefin.Soneticom.local>
In-Reply-To: <958023.73009.qm@web32203.mail.mud.yahoo.com>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: "Frank" <frannk_m1@yahoo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Yes, in my particular case I have 256MB of ram and want to cut off
about 16MB, so I passed it the argument mem=3D0x0EFFFFFF. I also tried
mem=3D240M, but it does not seem to work correctly. Whenever I pass it
those two options, Linux believes it has 191820K of memory, about 64MB
instead of the 16MB.

When I pass it a mem=3D argument that is lower than the 191820K, such as
mem=3D180M, the number decreases again, down to around 142M. Is there =
any
reason that Linux is allocating in huge blocks like that? Can I not be
so specific as to say the exact number of bytes I want Linux to see?

-----Original Message-----
From: Frank [mailto:frannk_m1@yahoo.com]=20
Sent: Wednesday, December 20, 2006 11:57 AM
To: Clint Thomas; linuxppc-embedded@ozlabs.org
Subject: Re: Define Linux system memory


--- Clint Thomas <cthomas@Soneticom.com> wrote:

> To anybody who has done this before or understands how to do this, I=20
> was wondering if you know how to "tell" the kernel how much memory=20
> there is in the system. An example would be if I have 512MB of RAM,=20
> but only want the system to know that there is about 500MB in RAM, so=20
> that 12MB does not exist to the OS/kernel. Would this require mucking=20
> about in U-boot?
> or can I just define this in the kernel source? Thanks
> =20
> Clinton Thomas
On the kernel command line passed by u-boot:
mem=3D500M

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around
http://mail.yahoo.com=20
