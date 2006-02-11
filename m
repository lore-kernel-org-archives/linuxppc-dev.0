Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB38067B7E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 12:12:40 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 16:10:32 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201BA2084@us-bv-m23.global.tektronix.net>
Date: Sat, 11 Feb 2006 02:12:37 +0100
Sender: wd@denx.de
Message-Id: <20060211011238.051C13525CC@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201BA2084@us-bv-m23.global.tektronix.net> you wrote:
> Since I have set IIP to 1, reset vector is at 0xfff00100.  IMMR is
> 0x00f00000. So, putting RAM at address 0x0 allows only 15MB of RAM
> at address 0x0 (ISA style). 

Please do yourself a favour and read some docs and FAQ's first.  With
a  low mapping ogf the IMMR like 0x00f00000 you will never be able to
run Linux.

And as mentioned before: the whole memory map is just software. If  it
doesn't fit your needs just change it.

> As memory and internal processor registers would conflict, I would have

Then CHANGE it! It's just a few bits in some registers.

> a memory hole.  Hence, the logical choice of putting RAM at a different

This is not a logical choice, but just another error.

> location. So, if MMU allows shadowing (which I have not read), it could
> solve my problem.

Please forget it. Just fix your memory map.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Why don't you have a Linux partition installed so you can be  working
in  a  programmer-friendly environment instead of a keep-gates'-bank-
account-happy one? :-)                            -- Tom Christiansen
