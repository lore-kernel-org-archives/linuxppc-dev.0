Date: Thu, 30 Aug 2001 09:19:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mvme5100 one more time...
Message-ID: <20010830091936.N18618@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010830170043.A8047@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010830170043.A8047@ipnpcu5.in2p3.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 30, 2001 at 05:00:43PM +0200, Xavier Grave wrote:

> I have compiled the last 2.4.10-pre1 kernel from linuxppc_2_4_devel
> and I try to do a :
> ppc6bug> nbo 0 0 ,,, zImage.pplus
>
> The only thing I have is the following :
> Exception : Program (Illegal instruction)

What CPU is this?  I'm assuming you get a register dump, can you post that
too?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
