Mime-Version: 1.0
Message-Id: <v04220800b69d5088a9c4@[10.0.0.42]>
In-Reply-To: <19341224043310.26390@mailhost.mipsys.com>
References: <200101280019.QAA15270@mail.turbolinux.com>
 <19341224043310.26390@mailhost.mipsys.com>
Date: Tue, 30 Jan 2001 21:36:35 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, <brad@turbolinux.com>,
        <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: powerbook doubles as a frying pan
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:01 PM +0100 1/29/01, Benjamin Herrenschmidt wrote:

>Troy have some code that allow to read the temp from /proc. However, it
>looks like a lot of CPUs are so badly calibrated that the information
>returned is almost useless... Maybe that's not the case in CPUs used in
>portables, that's the case in some of the G4s used in dual G4s.

G3s generally have a useful temperature sensor, but you have to know
the correction formula specific to the die revision you're using.
The raw data is not good for much other than deltas (i.e. if the raw
value changes by 12 C, you know that it really did change by about 12
C, even if you don't know what the real starting and ending temps
were).

However, from what I've heard the G4 sensor is essentially useless.
On my own dual processor 500, a MacOS temperature readout utility
consistently tells me that one processor is 24 degC (or more) cooler
than the other.  Both CPUs are the same die revision of course.
There is just no way for this to be correct; the CPUs are thermally
coupled by a nice thick chunk of aluminum (1" x 0.5" cross section at
least), due to the design of the heatsink.  Both are getting good
contact (I checked).

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
