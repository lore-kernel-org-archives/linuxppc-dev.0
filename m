Date: Mon, 15 Feb 1999 00:41:24 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Michel Lanners <mlan@cpu.lu>
cc: u497w7n9@umail.furryterror.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Why is -msoft-float used in Kernel compilation?
In-Reply-To: <199902142110.WAA00523@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.04.9902150025360.432-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 14 Feb 1999, Michel Lanners wrote:

> 
> On  13 Feb, this message from Gavriel State echoed through cyberspace:
> > 
> > I can understand using -msoft-float if CONFIG__8xx is on,
> > but why use it when compiling for 60x or 7x0 CPUs?
> 
> I've heard something about a 'no floiting point in kernel' rule, and
> I've tried compiling without -msoft-float.... it does boot, but it's an
> ugly sight... fp warning messages all over!
> 
> I have, however, never seen a clear explanation of why that rule
> exists...

I'm not sure, but I believe it's an optimization to allow the kernel to
not have to save floating point registers on every context switch.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
