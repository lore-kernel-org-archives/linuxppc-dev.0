Message-ID: <3B4B69E4.42178D5B@aps.anl.gov>
Date: Tue, 10 Jul 2001 15:47:32 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SSSSlllloooowwww MPC8240
References: <4.3.2.20010709213031.00c44910@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:
>
> Is caching enabled (both instruction and data)?  It sounds a lot like
> you are running without the benefit of caches.

That was it - thanks Jerry, I now get 133.12 BogoMIPS and a much more
responsive machine.

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
