Message-ID: <391C4DE9.67BE72B4@netx4.com>
Date: Fri, 12 May 2000 14:31:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with CPM I2C driver
References: <819E3E914E0AD11194DE00805F0D100B0138B857@fbi.infocom.dk> <391C3164.E68C4EC4@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:

> If your Ethernet is on SCC2 (which it should be), you don't need the
> patch unless you are using SPI.

Right, and further just don't use the microcode patches at all......

The patches seem to cause more problems than they fix, which
isn't necessarily the patches themselves, but a combination of
using the proper patch for the proper silicon revision and proper
driver modifications.  I don't even understand all of the permutations,
I can't get anyone from Motorola to explan all of them, and I simply
have some combinations that work and others that don't.

I dropped those functions there to make sure I don't lose them,
and I doubt they will work on anything other than one spcific
combination I was testing.

The microcode patches don't "fix" anything, since nothing is
really broken.  They simply relocate devices in the parameter RAM
memory space when something like Ethernet spills into a following
memory space.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
