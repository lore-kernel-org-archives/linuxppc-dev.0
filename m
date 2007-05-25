Return-Path: <dhlii@dlasys.net>
Message-ID: <465640C1.1060206@dlasys.net>
Date: Thu, 24 May 2007 21:49:53 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com> <465561A4.9020403@dlasys.net>
	<46558E54.80909@ru.mvista.com>
	<20070524154211.169C7AE8051@mail10-fra.bigfish.com>
In-Reply-To: <20070524154211.169C7AE8051@mail10-fra.bigfish.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Reissnegger wrote:
> Hi Andrei, David,
>
> It's great to hear that Andrei's git tree is active again.
>
> As you might have heard, Xilinx is in the process of setting up a git
> tree as well. Right now we are waiting for the new hosting machines to
> be installed. We should get those machines up and running shortly
> (within a couple weeks).
>   
Absolutely fantastic - however I think kernel.org would be happy to host
your git tree for you
as well as a few other places. Those are locations people would look for
public git trees.
I beleive you can still excecise some control. I beleive they are free -
though I suspect kernel.org would not
mind contributions from xilinx.
>  
> Currently the tree is based on mainline and adds support for MicroBlaze.
> I also intent to merge Grant Likely's virtex-dev branch, the framebuffer
> patch and the various other contributions that are out there. 
>   
You might want to look at the Microbalze-uClinux mailing list as well as
petalogix.
They are not using git yet, but they are puching the microblaze towards
kernel org
inclusion.


> We are also in the process of changing our internal coding guidelines to
> match the common Linux style (e.g. u32, u16 types, 8 char wide (tab)
> indentation, curly brace location etc) to make it easier to integrate
> code into the kernel and push it upstream.
>   

For me the most significant issue is the bazillion layers of nested
macro's and includes.

The kernel style guides atleast to me are primarily about the
readability and understandability of the code.
not where the curly brackets are.

> I'll send an update once we have the server up and running.
>
> Thanks,
>    Wolfgang
-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
