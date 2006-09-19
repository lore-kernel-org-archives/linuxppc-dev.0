Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8160767B85
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 09:26:12 +1000 (EST)
Date: Tue, 19 Sep 2006 16:26:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Steven Hein <ssh@sgi.com>
Subject: Re: JTAG debugger for MPC82xx/MPC83xx
Message-ID: <20060919232658.GD23636@mag.az.mvista.com>
References: <4510664B.2020304@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4510664B.2020304@sgi.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 04:51:07PM -0500, Steven Hein wrote:
> Hi,
> 
> My group is starting a new project includes a custom board
> with an MPC8258E processor on it.   I'm in the process
> of evaluating the state of the Linux kernel, toolchains,
> etc. for the MPC8258E/MPC8360E, as well as selecting a
> JTAG debugger for our project.
> 
> I've been researching the available JTAG debuggers that
> support the MPC82xx/MPC83xx family, and I've found these
> choices so far:
> 
> * Abatron BDI-2000
> * Green Hills Probe
> * Freescale's PowerTAP PRO for PowerPC
> * Lauterbach TRACE32-ICD
> * WindRiver ICE
> * Embedded Toolsmiths Guardian-SE (BUT...this is no longer
>   being sold, according to an email response I received
>   from Embedded Toolsmiths)
> 
> We will definitely want one with a network connection,
> and will will run the debugger software from a Linux host.
> Ideally, we would also like one that provides a library
> to allow us to write apps to function the debugger.
> 
> Can anyone comment on what JTAG debugger they are using,
> and how have your experiences been?   Are there any other
> good options besides the ones mentioned above.
> I'd appreciate any input.

You will find, by far, more bdi2000 users on the linuxppc-dev/embedded
lists than all the others debuggers combined, times 10, etc (at least,
they're that much more vocal).  Other linux arch's have a lot of bdi
users too.  There's even some powerpc linux kernel support for the bdi.

In general, the bdi works really well and their support is top notch.

I do not recieve any kickbacks from abatron, btw.  This question has
been asked before on this list (or -dev) so you can see other responses
in the archives.

Mark
