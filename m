Date: Thu, 15 Nov 2001 08:42:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: a general bootloader question
Message-ID: <20011115084201.A31998@cpe-24-221-152-185.az.sprintbbd.net>
References: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 15, 2001 at 11:51:55AM +0200, Shie Erlich wrote:

> 1) what is the proper way to get the kernel to boot - do i need a
> bootloader, if so, what ?

Of some sort, yes.

> 2) what is the bootloader's functionality - except downloading the kernel ?
> does it modify
>     memory in any way ? is the kernel dependent on such modifications ?

Well, in the simplest form, (what's in the linuxppc_2_4_devel tree), you
end up doing some very basic hardware checking/init'ing, decompress the
kernel and go.  For a 750 + cpc700 system this should be realativly
easy.  Take a look at how some of the other 7xx/74xx systems work in
there.

> 3) how can i make a bootloader load the kernel in low memory without
> changing KERNELBASE etc ?

Erm, I think this is a bit of a red herring...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
