Date: Mon, 31 Jul 2000 15:05:26 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where do head.S initialize UART?
In-Reply-To: <39857706.BBCBDD0@cern.ch>
Message-ID: <Pine.HPX.4.10.10007311503090.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 31 Jul 2000, Pei-Jie Hong wrote:

>
> I am porting Linux to a PowerPC VME board. I am now tracing head.S. Can
> anyone
> tell me where do head.S start to initialize the UART? Thanks.

It does not, the UART basic setup should be done by the Firmware or
perhaps by the initial bootloader. But otherwise it is postponed until
the console is initialized.

	Regards,
	Gabriel.


P.S: which VME board ? (I have a few Motorola's ones around 2400, and
2600)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
