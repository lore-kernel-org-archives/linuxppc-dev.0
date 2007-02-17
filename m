Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc3-s4.bay0.hotmail.com (bay0-omc3-s4.bay0.hotmail.com
	[65.54.246.204]) by ozlabs.org (Postfix) with ESMTP id 7963EDDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Feb 2007 04:51:12 +1100 (EST)
Message-ID: <BAY117-F2749592580AB79A5BB7457C8940@phx.gbl>
In-Reply-To: <BAY115-W166B09D1D3AD08D491466B2940@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: mamsadegh@hotmail.com, linuxppc-embedded@ozlabs.org
Subject: RE: What is the difference between Montavista Kernel Source
	andKernel.Org Source
Date: Sat, 17 Feb 2007 12:51:06 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




>From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
>Subject: What is the difference between Montavista Kernel Source 
>andKernel.Org Source
>Date: Sat, 17 Feb 2007 15:09:29 +0000
>
>I want to know, what is the difference between the linux kernel source, 
>that we download from source.mvista.com ( using git ) and the original 
>kernel source code that we download from kernel.org?
>
>In other words, Suppose that I have generated the BSP in EDK ( version 
>8.2.02 ) , and now , I copy this BSP to the root folder of kernel source 
>obtained from kernel.org instead of mvista. Can I do the same things as 
>mvista source in this case?


I would recommend doing a diff across the two source trees.
Since there are so many different versions and patches available, it is the 
only way to really know the true differences.  It's usually never as simple 
as just knowing based on the version numbers alone.

_________________________________________________________________
Don’t miss your chance to WIN 10 hours of private jet travel from Microsoft® 
Office Live http://clk.atdmt.com/MRT/go/mcrssaub0540002499mrt/direct/01/
