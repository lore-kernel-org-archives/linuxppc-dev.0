Message-ID: <3D516845.6080606@gmx.de>
Date: Wed, 07 Aug 2002 20:34:45 +0200
From: Michael Habermann <MHabermann@gmx.de>
MIME-Version: 1.0
To: Narendra <narengh@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CS_BAD_VCC Error during Card Configaration.
References: <20020807104433.21385.qmail@webmail5.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Narendra wrote:
> I have one more problem,
> Do i need to compile my kernel with Enabling PCMCIA support and
> then download to target? or Is it sufficient if all pcmcia driver
> modules are loaded to kernel??

PCMCIA needs and should not be enabled in the kernel. The loading the
modules is enough.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
