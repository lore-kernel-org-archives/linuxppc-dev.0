Return-Path: <timur@freescale.com>
Message-ID: <4741BDA7.8020106@freescale.com>
Date: Mon, 19 Nov 2007 10:45:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	
	<4741A56D.9050808@freescale.com>	
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
In-Reply-To: <9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Now how do I pick which fabric driver to initialize?

I'm doing it via a Kconfig option.  For ASoC V1, I think that's the only way 
that works.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
