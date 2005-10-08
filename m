Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sat, 8 Oct 2005 15:26:36 -0700
To: Linuxppc-embedded@ozlabs.org
Message-ID: <20051008222636.GA816@xyzzy.farnsworth.org>
References: <8e78982e0510080306n48d9c8b2p858f22bed588f6b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8e78982e0510080306n48d9c8b2p858f22bed588f6b9@mail.gmail.com>
Subject: Re: USB IRQ Handling in IBMSTBx25xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Oct 08, 2005 at 10:06:36AM +0000, Vijesh VH wrote:
> Has any one worked on Interrupt handling in PPC 405 for STBx25xx. I am
> working in interfacing USB devices for STB. The Device Driver is getting
> stuck or runs unconditional in calling ISR. I Identified that that the
> spin_unlock_irqrestore function call in the kernel does it. So i am unable
> to go ahead and could not find what to do further. If any one is aware or
> worked on this kind of problem plz help me.

On which kernel?

It works for me in linux-2.6.13.

-Dale
