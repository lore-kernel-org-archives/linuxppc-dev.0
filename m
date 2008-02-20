Return-Path: <galak@kernel.crashing.org>
Message-Id: <7CDED5EA-D72B-4D9F-A547-AC3B6A59F174@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: raul.moreno@telvent.abengoa.com
In-Reply-To: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 2.6.24 for mpc8458amc
Date: Tue, 19 Feb 2008 23:19:18 -0600
References: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
Cc: maxime louvel <m.louvel@gmail.com>,
	linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 19, 2008, at 6:19 AM, raul.moreno@telvent.abengoa.com wrote:

>
> Hello Maxime,
>
> if your board is still running, although you can't see the messages  
> that
> means you don't have any console. Try to set one (I think you can  
> use a SCM
> of the CPM) in the kernel configuration (characters devices)  or in  
> the
> command line (console=).

If you really have a mpc8548 than there is no CPM.  It has 16550 style  
UARTs on it.

- k
