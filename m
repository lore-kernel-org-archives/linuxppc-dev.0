Message-ID: <3F8E43D8.6090904@imc-berlin.de>
Date: Thu, 16 Oct 2003 09:08:08 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx memory mapped 16550A uart garbage
References: <3439AB3A99ECD5409F3A52ACF814744D158DA1@norcom2.norcom.net>
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158DA1@norcom2.norcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh,

> I did measure the bit width and that is around 104us, which is correct.
> Anything else?

Hmm. I suppose you tried sending only character again and again and verified
that your board is indeed sending this character over the lines by looking at
the scope...


Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
