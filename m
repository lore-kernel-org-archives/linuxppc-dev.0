Return-Path: <greg.weeks@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 84B9467B59
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 10:59:51 +1000 (EST)
Message-ID: <451089AC.7060500@timesys.com>
Date: Tue, 19 Sep 2006 20:22:04 -0400
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Subject: Re: JTAG debugger for MPC82xx/MPC83xx
References: <4510664B.2020304@sgi.com>
In-Reply-To: <4510664B.2020304@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Steven Hein wrote:
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
>   
The only one I've used for power pc is the BDI. I've not tried it on the 
83xx yet, but others here have. It worked well with the 82xx. I mostly 
used gdb to talk to it over ethernet.

Greg Weeks
