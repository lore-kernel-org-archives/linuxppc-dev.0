Return-Path: <albert_herranz@yahoo.es>
Received: from smtp135.mail.ukl.yahoo.com (smtp135.mail.ukl.yahoo.com
	[77.238.184.66]) by ozlabs.org (Postfix) with SMTP id 6A0A9B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 16:45:30 +1100 (EST)
Message-ID: <4B14AD76.4030401@yahoo.es>
Date: Tue, 01 Dec 2009 06:45:26 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <cover.1259609263.git.albert_herranz@yahoo.es>	
	<86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>	
	<4B147086.6070602@gmail.com> <4B14A834.4070907@yahoo.es>
	<1259646011.4502.4.camel@concordia>
In-Reply-To: <1259646011.4502.4.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Richard Holden <aciddeath@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>>> you may want to rename the ug_ prefix, it took me a while looking back
>>> and forth through the patch to convince myself it wasn't a typo.
>>>
>> What's wrong with ug_ ? (ug = (u)sb(g)ecko)
> 
> What's wrong with usb_gecko_early_remap() :)
> 

Nothing, except that names end up been way long for my taste (like for example usb_gecko_early_grab_exi_io_base())
I prefer to use a shorter prefix consistently.

But that's my taste :)

Cheers,
Albert
