Date: Sat, 3 Jun 2000 17:31:10 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <20000603170917.A11644@quaketop.them.org>
Message-ID: <Pine.LNX.4.10.10006031728230.9136-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 03, 2000 at 08:28:25AM +0200, Michel Lanners wrote:
> For those with multiple display adapters, do you think an option
> controlfb:off might make sense? As there is no way to control which card
> gets assigned which framebuffer device, that might help in certain
> situations...

I believe you can set which driver gets init'ed first by using the args:

video=foo:blah video=bar:blah

foo's _init will be called first, and bar's next, (therefore being fb0 and
fb1 respectively).


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
