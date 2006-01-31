Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9C9BD68A5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 08:13:20 +1100 (EST)
To: =?iso-8859-9?Q?Mustafa_=C7ay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Entry Point Address 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 31 Jan 2006 15:26:39 +0200."
	<000e01c62669$f7c3be60$9e01120a@bilisim.local>
Date: Tue, 31 Jan 2006 22:13:19 +0100
Sender: wd@denx.de
Message-Id: <20060131211319.086153535E8@atlas.denx.de>
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

In message <000e01c62669$f7c3be60$9e01120a@bilisim.local> you wrote:
>  
> does entry point adress defined uboot image header correspond to adress of which function in linux kernel ?

It corresponds to the kernel's entry point, "_start".

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Cigarette, n.: A fire at one end, a fool at the other, and a  bit  of
tobacco in between.
