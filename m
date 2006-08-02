Return-Path: <wd@denx.de>
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Aug 2006 15:59:06 CDT."
	<1154552346.5550.51.camel@localhost>
Date: Thu, 03 Aug 2006 00:33:02 +0200
Sender: wd@denx.de
Message-Id: <20060802223302.9667135360F@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1154552346.5550.51.camel@localhost> you wrote:
> 
> And the new cuImage will look like this:
> 
> -------------------------------------
> -	compressed uImage	  - -
> - ------------------------------- - -
> - - 	_start			- - -
> - -	boot wrapper code	- - -
> - - ----------------------------- - -
> - - -	device tree	      	- - -
> - - ----------------------------- - -
> - - ----------------------------- - -
> - - - 			      	- - -
> - - - 	UNcompressed	      	- - -
> - - - 	kernel image	      	- - -
> - - -			      	- - -
> - - ----------------------------- - -
> - --------------------------------- -
> -------------------------------------

Please explain.

In my understanding, an "uImage" file is a  image  consisting  of  an
U-Boot  header (64 bytes) followed by an (compressed or uncompressed)
Linux kernel image.

So what do you mean by "compressed uImage"? If you take  an  "uImage"
file  according  to  above definition and compress it, it will not be
recognized by U-Boot.

And why do you need a second, "UNcompressed  kernel  image"  in  your
setup?  I  must  be missing something, because including *two* kernel
images makes no sense to me, and I don't  understand  why  you  would
want to insist of an "UNcompressed" image...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
1st Old Man:  Gee, its windy today.
2nd Old Man:  No it's not... it's Thursday.
3rd Old Man:  Yeh, me too.  Let's go for a beer.
