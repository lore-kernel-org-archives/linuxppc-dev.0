Date: Wed, 3 Oct 2001 16:31:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Grant Erickson <erick205@umn.edu>
Cc: dmalek@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH]: linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c
Message-ID: <20011003163105.A18612@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.SOL.4.20.0110031419450.10159-200000@garnet.tc.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.4.20.0110031419450.10159-200000@garnet.tc.umn.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 03, 2001 at 02:22:06PM -0500, Grant Erickson wrote:

> Please accept the attached patch to ppc4xx_setup.c. It attempts to make
> the 4xx 'progress' method more consistent with other subarchitectures and,
> at the very least, makes it respectful of the kernel 'quiet'
> flag--important when you want a fast kernel boot.

Ack, no, please no.  How does removing the other bits it prints out
make it respectful of the 'quiet' argument anyways?  Anyhow, I'd really
rather not push this since I've got a more 'proper' version (that
writes directly to the serial port instead of waiting for printks to
go) that I'll hopefully get right soon.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
