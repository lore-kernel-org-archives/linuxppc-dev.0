Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0D232DDF72
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Mar 2007 05:38:29 +1000 (EST)
To: "Ken Sakurai" <sakurken@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AVNET 440GX board 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Mar 2007 13:45:50 EST."
	<393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com>
Date: Sun, 25 Mar 2007 21:38:27 +0200
Sender: wd@denx.de
Message-Id: <20070325193827.4EF3A35264E@atlas.denx.de>
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

In message <393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com> you wrote:
> 
> I was just using the elf image, instead of uimage.
> '6501A8C0.img' is refereing zImage.img which is Linux elf image.
> It looks to me that the bootelf command interprets ELF format corrently.

You shoulkd really read the documentation. bootelf is not the correct
command to boot a Linux kernel image, and the ELF file is not the
correct image to use.

Also, "6501A8C0.img" means you fell back to using the encoded IP
address of yoru target as file name because you failed to provide a
valid image name.

Again, I strongly recommend to read the fine manual.

> On 3/23/07, Stefan Roese <sr@denx.de> wrote:

[Full quote deleted.]

Please don't top post / full quote.

Read http://www.netmeister.org/news/learn2quote.html

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
HEALTH WARNING: Care Should Be Taken When Lifting This Product, Since
Its Mass, and Thus Its Weight, Is Dependent on Its Velocity  Relative
to the User.
