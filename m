Return-Path: <bwarren@qstreams.com>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by ozlabs.org (Postfix) with SMTP id 66C44DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 11:45:54 +1100 (EST)
Message-ID: <478417B0.5030705@qstreams.com>
Date: Tue, 08 Jan 2008 19:39:12 -0500
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Jeff Parent <jeff.parent@gmail.com>
Subject: Re: PowerPC Cross Compiler's Arch doesnt match
References: <464e946e0801081339o2585362ci5b209154a8526089@mail.gmail.com>
In-Reply-To: <464e946e0801081339o2585362ci5b209154a8526089@mail.gmail.com>
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

Hi Jeff,

Jeff Parent wrote:
> I'm building a linux distro for work, that runs on embedded systems 
> with either and ARM 9 or a PowerPC 603.  I've had great luck building 
> a cross compiler w/ crosstools and using them in the compiler jail 
> created by Scratchbox.  Now I am working on porting all my work to the 
> PowerPC.  When I build the cross compilers I have selected GCC-4.0.1 
> and GLIBC-2.3.5 for both setups.  I create my jail in Scratchbox for 
> the PowerPC and try compiling any of the GNU applications and when 
> running the configure script I get:
>
I have no idea what Scratchbox is, but when running gnu configure to 
cross-compile something, you typically need to supply the following 
switches:

--host=powerpc-linux --build=i686

and CC will have to point to your cross compiler (e.g. export 
CC=powerpc-linux-gcc, or export CC=ppc_6xx-gcc, whatever your cross 
compiler is called).  Of course, the values of these switches will 
depend on your setup, but this is what I use and I've built all sorts of 
packages from source.

regards,
Ben
