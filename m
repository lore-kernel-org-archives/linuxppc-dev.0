Message-ID: <3B366E75.B83D485A@mvista.com>
Date: Sun, 24 Jun 2001 18:49:25 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Guillaume =?iso-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: another endianness issue...
References: <3B2E747A.6090607@noos.fr> <01061823464800.00690@reality.internal> <3B2F0871.2070304@noos.fr> <0106192003070C.00609@reality.internal> <3B34616F.2090403@noos.fr> <v04220800b75a8da0ed9d@[10.0.0.42]> <3B35F23B.5030003@noos.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guillaume Laurès wrote:

> static inline
> boolean DAC960_BA_InitializationInProgressP(void *ControllerBaseAddress)
> {
>   DAC960_BA_InboundDoorBellRegister_T InboundDoorBellRegister;


It would also be nice if you would read the Linux kernel coding
standards
document.  Upper/lower case and thirty character object names are
not appreciated.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
