Date: Fri, 9 Jan 2004 09:20:25 -0800
From: Brad Boyer <flar@allandria.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Why does config MAC_EMUMOUSEBTN depend on INPUT_ADBHID ?
Message-ID: <20040109172025.GB24203@pants.nu>
References: <20040109131027.GJ31820@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040109131027.GJ31820@sunbeam.de.gnumonks.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 09, 2004 at 02:10:27PM +0100, Harald Welte wrote:
> Can anybody please explain why this dependency exists?  On my desktop G4
> machine, there is no need to compile ADB support, since it uses an usb
> keyboard.  However, I'd still like to have the mouse button emulation.

I think it's mostly historical. I'm pretty sure that it was originally
tied in very intimately to ADB. These days it's tied into the input
system, and is mostly independent. It does declare itself to be an
ADB device, tho. I'm not sure if that will confuse anything if there
isn't ADB support in the kernel.

> I cannot select it without compiling the (for this machine) superfluous
> ADB support.
>
> Is this intentional?

I'm pretty sure it isn't intentional. I suspect noone cared enough to
fix the dependency when it was no longer important.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
