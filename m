Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id BF3FE679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Mar 2006 09:37:29 +1100 (EST)
Message-ID: <4424750C.7020809@ovro.caltech.edu>
Date: Fri, 24 Mar 2006 14:39:08 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Diagnostic tool
References: <F795765B112E7344AF36AA9112796415019ECEBA@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA9112796415019ECEBA@xmb-sjc-212.amer.cisco.com>
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

Bizhan Gholikhamseh (bgholikh) wrote:
> Hi,
> 
> I am using PQIII Freescale cpu 8541 on a custom board.
> 
> Is anyone aware of diagnostics tool as a kernel module to test cpu, 
> memory and other hardware components that may be out there. This is 
> normally a test suit that will be used manufacturing for extensive HW 
> testing.
> 

The AMCC Yosemite 440EP board came with a proprietry
package called Kozio Diagnostics. If you don't get
any nice open source suggestions, you could check
them out. On the Yosemite board, they were run from
the U-Boot prompt as a stand-alone application.

Personally I'm not a fan of proprietry stuff, and would
write my own, but since you asked ...

Dave
