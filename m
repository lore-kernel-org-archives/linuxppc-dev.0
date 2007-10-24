Return-Path: <timur@freescale.com>
Message-ID: <471F6761.3030405@freescale.com>
Date: Wed, 24 Oct 2007 10:40:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<471E12C7.8020509@freescale.com>	
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>	
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	
	<471F52ED.10007@freescale.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<9e4733910710240823v2022661ftb1b754a86cab88f3@mail.gmail.com>
In-Reply-To: <9e4733910710240823v2022661ftb1b754a86cab88f3@mail.gmail.com>
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

> I see your point about putting the child node onto the control bus.
> ac97 is both a control and data bus. For the i2s case the child should
> go onto the i2c bus.

I know AC97 is *also* a control bus, but treating I2S and AC97 differently is 
bad, IMHO.  If you're going to put the child node in the AC97 node, you should 
also put it in the I2S node.

The 8610 has an SSI that can operate as either AC97 or I2S.  If I want to switch 
from AC97 to I2S, I should not have to move the child node out of the AC97 node. 
  I should instead just add an I2C node and point to it.
