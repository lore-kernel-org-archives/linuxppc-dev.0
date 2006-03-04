Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 424EF67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 13:05:32 +1100 (EST)
To: David Hawkins <dwh@ovro.caltech.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux on PPC 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Mar 2006 08:53:07 PST."
	<44087473.6020905@ovro.caltech.edu>
Date: Sat, 04 Mar 2006 03:05:29 +0100
Sender: wd@denx.de
Message-Id: <20060304020529.F1CDF352627@atlas.denx.de>
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

In message <44087473.6020905@ovro.caltech.edu> you wrote:
> 
> > Many memory maps (especially those provides with some eval boards for
> > demonstration purpose) will NOT work with Linux.  Remember  that  the
> > memory  map  is  usually  not  cast  in  silicon,  but implemented in
> > software, so you can change it as needed.
> 
> Right, thats I made sure to say; Physical Memory Map.

That's what I mean: the physical memory map  is  usually  set  up  in
software, so it can be changed to your needs.

> For example, on the Artesyn manual on their PrPMC they give a
> physical memory map, and in the Yosemite board, there is a
> physical memory map. I know many of the memory areas can be
> redefined in hardware to have a different memory location, but
> its still a physical address.

...which usually can be reprogrammed in software.

> Now, when the bootloader loads, eg. U-Boot, it sets up the
> memory management. Now this is where my understanding gets
> shakey, since I haven't looked at much of the code, so perhaps
> you can clarify. The translation unit (TLB) maps virtual addresses
> (or should that be MMU output addresses) into physical addresses,

U-Boot usually does not use the MMU. 

> What are the basic requirements for a Linux memory map then?

See the FAQ.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is surely a great calamity for  a  human  being  to  have  no  ob-
sessions.                                                - Robert Bly
