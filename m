Date: Wed, 18 Sep 2002 09:28:05 -0500
Subject: Re: mpc8xx fpu emu
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: Conn Clark <clark@esteem.com>, Alban Wood <awood@bloodwolf.org>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
To: Dan Malek <dan@embeddededge.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <3D80D9E1.1020001@embeddededge.com>
Message-Id: <D8A0BB5A-CB12-11D6-AAF4-003065BFB10E@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> Even when you don't enable the kernel FPU emulation, we still emulate a
> few FP instructions.  This is to allow programs that use absolutely no
> floating point to work with the generic FPU PowerPC libraries.

Can you elaborate on this?  Why exactly is this done?  Is it because
glibc has some minor FP code @ startup?

thanks

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
