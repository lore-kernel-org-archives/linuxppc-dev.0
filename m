Subject: Re: confused about HID1 bits and G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Watson <gwatson@lanl.gov>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <B77CD81E-99EE-11D8-B5B8-000393A47A5C@lanl.gov>
References: <408FEBB6.105@nortelnetworks.com>
	 <1083191370.21436.81.camel@gaston> <409108FE.70500@nortelnetworks.com>
	 <B77CD81E-99EE-11D8-B5B8-000393A47A5C@lanl.gov>
Content-Type: text/plain
Message-Id: <1083275387.29594.146.camel@gaston>
Mime-Version: 1.0
Date: Fri, 30 Apr 2004 07:49:48 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-30 at 01:05, Greg Watson wrote:
> As a firmware designed (LinuxBIOS), I would support this. Obviously
> there are some things that the firmware has to do, like enable memory,
> but the less reliance the o/s has on magic behavior the better. It
> makes firmware design simpler and more reliable.

There is nothing like "magic behaviour" here. There is a set of
features that should normally be enabled on the CPU, this set is
clearly defined in the spec, the firmware should enabled them.

As I wrote, I prefer not touching most of this from the kernel since
some specific CPU rev. errata may involve disabling some of those,
and that is typically done by the firmware, at least on pmacs. Now,
it's possible that I decide to force more of these bits myself based
on experience with broken firmwares, but so far, this has not been
necessary :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
