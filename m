Date: Wed, 23 Jun 2004 08:20:28 -0500
From: David Wolfe <david.wolfe@freescale.com>
To: I?igo Lopez Barranco <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 USB with Vbus=1.7V
Message-ID: <20040623132028.GA1311@orthanc.sps.mot.com>
References: <42A622EB18325843894BB8E1040E3DF502275A@sinaexchf> <42A622EB18325843894BB8E1040E3DF5022759@sinaexchf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A622EB18325843894BB8E1040E3DF502275A@sinaexchf> <42A622EB18325843894BB8E1040E3DF5022759@sinaexchf>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ I?igo Lopez Barranco writes: ]
> The only strange thing is that in Motorola's schematics says that
> pins 3 and 5 of the Micrel 2025 are Not Connected and 4 is GND, and
> Micrel's 2025 datasheet says that 3 is GND and 4 and 5 NC. Then, in
> the Lite5200 GND pin 3 is connected to GND through an 1k resistor,
> instead of directly as I suppose they pretended in the schematic, and

That is correct and an error in our Lite5200 layout. Thanks for the
feedback. We are replacing R164 with a 0 Ohm resistor. Our Total5200
platform does not share this problem.

--
David Wolfe
Digital Audio, Radio & Telematics
Freescale Semiconductor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
