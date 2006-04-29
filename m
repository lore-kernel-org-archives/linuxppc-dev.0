Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EC38679F9
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 01:33:35 +1000 (EST)
In-Reply-To: <20060429083743.64CA7353A56@atlas.denx.de>
References: <20060429083743.64CA7353A56@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD3A7629-F190-49A5-BF90-A1097CC42AF2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Sat, 29 Apr 2006 10:33:24 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2006, at 3:37 AM, Wolfgang Denk wrote:

> In message <20060429005231.GH458@smtp.west.cox.net> you wrote:
>>
>>> In my understanding, 1. is with a shim; 2. is loading a separate   
>>> dtb
>>> (probably  as  multi-file  image), and 3. is when U-Boot provides  
>>> the
>>> dtb. Am I missing something?
>>
>> I'm suggesting that we make 2 easier.  U-Boot needs the file  
>> mkuimage'd
>> anyways.  Why not make it easier and make adding the dtb part of that
>> step instead of a seperate load?  It's still quite easy to replace if
>> you're testing new dtb's out.
>
> But that's what I'm trying to  tell  you  all  the  time.  An  U-Boot
> multi-file  image is a single file (=no separate load) which combines
> several files (similar to a  tarball),  here  the  kernel  +  dtb  (+
> eventually ramdisk).

This was my intent for #2.  You could either provide an explicit  
image or use a multi-file image.  I was going to look at having the  
default build target that we use for uImage create a multi file image  
(kernel & dtb) so the user still only sees one image.

- kumar
