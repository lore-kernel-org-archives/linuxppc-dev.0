Date: Thu, 19 Jun 2003 14:18:16 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo upgraded to 750fx not detected correctly
In-Reply-To: <Pine.LNX.4.10.10306122335280.3129-100000@pneuma.phys.ualberta.ca>
Message-ID: <Pine.LNX.4.44.0306191415050.16134-100000@stoa.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Jun 2003, Terry Greeniaus wrote:

> The PowerLogix 900 MHz bluechips are 750FX CPUs, however they have been
> strapped so that the PVR reports itself as 0x0008nnnn instead of
> 0x7000nnnn, so that Apple's OpenFirmware can better support them (in
> particular, to automatically enable the L2 cache).  The correct way (on
> these boards, anyhow) to determine if this is a 750FX is by writing to
> the HID1 register and seeing if it changed.  I have a code snippet to do
> this if anyone wants it, although it isn't LinuxPPC-specific.  This is
> backwards-compatible with normal 750 CPUs, they don't take an exception
> if you try to write to the HID1 register.

I would like to see the code snippet.  Do you know how the bluechip G4
upgrade for the pismo works?  Is it also reported as 0x0008nnnn?  If so,
how does your code snippet handle that case?

Chris.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
