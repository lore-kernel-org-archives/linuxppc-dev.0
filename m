Message-ID: <3AF71B00.E3FCEA37@mvista.com>
Date: Mon, 07 May 2001 18:00:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Freddy Lugo <wilflugo@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can not access memory after turning MMU on
References: <20010507204100.56613.qmail@web9901.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Freddy Lugo wrote:

> This register exists or has its counterpart on the
> MPC750?  Besides the DER value, there are other
> methods to work and find the problem?

You are way, way, way lost...........You can't be building MPC8xx
code and expecting it to run on the 750.  You need to select a
kernel configuration that enables 6xx/7xx/74xx processors and
a CHRP reference design.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
