Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.mud.yahoo.com (smtp102.biz.mail.mud.yahoo.com
	[68.142.200.237]) by ozlabs.org (Postfix) with SMTP id 3197B679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 00:20:32 +1000 (EST)
Subject: Re: Problems dynamically linking busybox with ppc libs.
From: Ben Warren <bwarren@qstreams.com>
To: Keith Redfern <keith.redfern@uk.flextronics.com>
In-Reply-To: <367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.com>
References: <367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.com>
Content-Type: text/plain; charset=windows-1251
Date: Wed, 16 Aug 2006 10:13:21 -0400
Message-Id: <1155737601.12539.34.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Keith,

On Wed, 2006-08-16 at 10:53 +0200, Keith Redfern wrote:
> I am trying to dynamically link busybox with the correct libraries but
> run into problems with directory paths and CC/LD flags.
> 
> I am using the toolchain supplied with ELDK and my target board is
> ppc_8xx based. The busybox version that I am using is 1.1.3.
> 
<snip>
> 
> Is this the correct place to make modifications?
> 
> Has anyone already figured the changes required to get this to work
> with ELDK toolchain?
> 
> Any insight would be useful.
> 
>  
> 
> ...…Keith

I have busybox 1.2 building under ELDK 4.0, and didn't mess at all with
the Make system, and am building for a ppc_6xx- target.  I realize this
isn't quite your setup, but is pretty close.

As long as you have the tools listed in your PATH (in my
case /opt/tools/eldk4.0/usr/bin:/opt/tools/eldk4.0/bin), you should be
able to build fine using 'make menuconfig'.  Just go to 'Busybox
Settings->Build Options' and select 'Do you want to build BusyBox with a
Cross Compiler?', in your case entering 'ppc_8xx-' or whatever the
prefix is for your CPU.

regards,
Ben
