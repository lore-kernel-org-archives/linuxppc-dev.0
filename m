Date: Tue, 24 Jul 2001 10:11:46 -0700
From: Matt Porter <mporter@mvista.com>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'Matt Porter'" <mmporter@home.com>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4.6 kernel on MCP750 board
Message-ID: <20010724101146.A21725@cx258813-a.chnd1.az.home.com>
References: <619D608DD3F0D311882C009027732E1A353222@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <619D608DD3F0D311882C009027732E1A353222@ntserver.act.domain>; from rudolf.ladyzhenskii@act-aus.net on Mon, Jul 23, 2001 at 11:03:12AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 23, 2001 at 11:03:12AM +1000, Rudolf Ladyzhenskii wrote:
>
> Thanks, Matt
>
> Your patch did make things a bit better. Now it tries to initialize the
> tulip, but I do not think it is very happy.
> Kernel tries to send BOOTP requests, but they never reach the server.
> And tulip driver complains about missing EEPROM. Old kernel was finding the
> EEPROM OK. Also, MAC address is changing between two kernels somehow. I
> assume it is due to the detection of an EEPROM.
>
> I've included updated start up dump.

Are you running linuxppc_2_4_devel or a kernel.org 2.4.6?  What rev. of
mcp750?

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
