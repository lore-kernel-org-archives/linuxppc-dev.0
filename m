Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id DA0BC67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 07:40:40 +1000 (EST)
To: "Edward Jubenville" <edjubenville@adelphia.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 30 Mar 2005 12:57:23 -0800."
	<GPECLCIGPLHEOMGPMCPAOEOJCMAA.edjubenville@adelphia.net>
Date: Wed, 30 Mar 2005 23:40:11 +0200
Sender: wd@denx.de
Message-Id: <20050330214016.EE37CC108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB support on Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ed,

in message <GPECLCIGPLHEOMGPMCPAOEOJCMAA.edjubenville@adelphia.net> you wrote:
> I'm using a FreeScale Lite5200 development board with an MPC5200.  I used
> ELDK 1.3 and DAS U-Boot to get a working kernel, booted, etc., but I later
> found that the configuration I chose (icecube_5200_defconfig) didn't have
> USB support enabled.
> 
> My first USB goal is hook up a SanDisk cruzer 256 MB memory stick.  Which
> configuration options need to change?  Is there a HOWTO or example
> configuration file somewhere?

See Documentation/Configure.help for a description  of  the  configu-
ration options.

> Eventually, I would like to support at least one kind of USB keyboard.
> Where can I find guidance for that configuration.

For a start, you can use  the  "icecube_5200_CoralP"  which  has  USB
support (for mouse, keyboard, mass storage devices) enabled.

For example, compare the config files like this:

	diff arch/ppc/configs/icecube_5200{,_CoralP}_defconfig


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Brontosaurus Principle: Organizations  can  grow  faster  than  their
brains  can manage them in relation to their environment and to their
own physiology: when this occurs, they are an endangered species.
                                                - Thomas K. Connellan
