Subject: Re: Best compiler/flags combination
To: pavel_roskin@geocities.com (Pavel Roskin)
Date: Mon, 31 Jan 2000 10:21:30 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0001281444060.32290-100000@sunapee.transcept.com> from "Pavel Roskin" at Jan 28, 2000 03:06:45 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000130232130.B959B1B3E0@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin writes:
> I'm using egcs-1.1.2 and glibc-2.1.1 with patches from LinuxPPC (i.e. I
> use their source RPM's).
>
> The question is, what compiler is known to produce good code for embedded
> PPC boards and what flags should be used? It is desireable that the
> binaries still run on PowerPC.

My general approach when starting out is to always use the latest official
released versions, and move to a newer snapshot if you encounter problems.
In particular, the latest official gcc release (gcc-2.95.2) is a better
starting point than the old egcs releases.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
