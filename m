Message-ID: <3C586F78.5040106@embeddededge.com>
Date: Wed, 30 Jan 2002 17:11:04 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SMC2 causes failure?
References: <638AA0336D7ED411928700D0B7B0D75B01E2011D@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gessner, Matt wrote:

> I'm experimenting getting SMC2 up and running as my console.


The SMC2 isn't a very good choice for a console if you intend to use
it beyond some simple boot up messages.  It is one of the first
peripherals confiscated by other CPM functions, either by the assignment
of the I/O pins to some other use or the use of the parameter ram.

> Interestingly enough, when the machine boots, it gets locked
> into a page fault loop.

Are you loading a microcode relocation patch (or was one loaded and not
removed properly) without proper driver modifications?

Since the console is the first thing used by the kernel in the IMMR space,
do you have that mapped properly?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
