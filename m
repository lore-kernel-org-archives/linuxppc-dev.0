From: Benjamin Herrenschmidt <bh40@calva.net>
To: Olaf Hering <olh@suse.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ThinkPad 850 Patches for 2.2.16
Date: Tue, 24 Oct 2000 21:22:20 +0200
Message-Id: <19340918125404.28619@192.168.1.10>
In-Reply-To: <20001024200338.A908@suse.de>
References: <20001024200338.A908@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The sound stuff should be moved out of arch/ppc into the driver cs4232, you
>can't have it as a module right now. xmms works fine, but I have many
>dropouts. Any ideas how to finetune that?
>That sound-patch will proably break the other PReP machines, I will test
>it on the 43p 133 later. We need proably a _PREP_IBM_portable or so.

No please ;)

I beleive you must have a way to probe for the machine type and do the
right thing, don't you ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
