From: benh@kernel.crashing.org
To: <hobold@Informatik.Uni-Bremen.DE>,
	Edward Swarthout <Ed.Swarthout@Motorola.com>
Cc: <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: Support for new Dual G4 1 Gig machines?
Date: Tue, 29 Jan 2002 20:09:40 +0100
Message-Id: <20020129190941.5062@mailhost.mipsys.com>
In-Reply-To: <200201291701.g0TH1a318829@pacific.somerset.sps.mot.com>
References: <200201291701.g0TH1a318829@pacific.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The 7455 uses bit 8 for HIGH_BAT_EN.  On the 7400/7410, bit 8 is DOZE
>Enable and on the 7450 it is ignored.  So, code ported from the 7400
>which happens to set bit 8 will work fine on the 7450 but cause great
>grief on the 7455.  Random translations whose side effects don't get
>detected until much later tend to make system debug difficult...

If I didn't fuck it up too much, the latest kernels will not set
the DOZE bit on those CPUs if they have a proper cputable entry
(basically copy the 7450 one).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
