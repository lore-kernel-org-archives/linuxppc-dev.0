In-Reply-To: <1083275387.29594.146.camel@gaston>
References: <408FEBB6.105@nortelnetworks.com> <1083191370.21436.81.camel@gaston> <409108FE.70500@nortelnetworks.com> <B77CD81E-99EE-11D8-B5B8-000393A47A5C@lanl.gov> <1083275387.29594.146.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42A58B44-9A33-11D8-B5B8-000393A47A5C@lanl.gov>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Chris Friesen <cfriesen@nortelnetworks.com>
From: Greg Watson <gwatson@lanl.gov>
Subject: Re: confused about HID1 bits and G5
Date: Thu, 29 Apr 2004 17:16:35 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 29/04/2004, at 3:49 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2004-04-30 at 01:05, Greg Watson wrote:
>> As a firmware designed (LinuxBIOS), I would support this. Obviously
>> there are some things that the firmware has to do, like enable memory,
>> but the less reliance the o/s has on magic behavior the better. It
>> makes firmware design simpler and more reliable.
>
> There is nothing like "magic behaviour" here. There is a set of
> features that should normally be enabled on the CPU, this set is
> clearly defined in the spec, the firmware should enabled them.
>
> As I wrote, I prefer not touching most of this from the kernel since
> some specific CPU rev. errata may involve disabling some of those,
> and that is typically done by the firmware, at least on pmacs. Now,
> it's possible that I decide to force more of these bits myself based
> on experience with broken firmwares, but so far, this has not been
> necessary :)

Well the good thing about LinuxBIOS is you can fix the firmware. :-)

Greg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
