Message-Id: <200003091604.LAA24832@mal-ach.watson.ibm.com>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: Message from Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
   of "Thu, 09 Mar 2000 15:46:38 +0100." <4.3.2.20000309152803.00ca9100@mail.munich.netsurf.de>
Date: Thu, 09 Mar 2000 11:04:56 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Franz Sirl writes:

Franz> -O2, -O3, -funroll-loops, -funroll-all-loops, -ffast-math (dunno if this
Franz> one has an effect on PPC at all), -finline-functions, -mcpu=604, -mcpu=750

	-ffast-math does enable use of the FP "fsel" instruction for
conditional moves.  -ffast-math also affects other floating-point
optimizations in the compiler, not just specific architecture features.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
