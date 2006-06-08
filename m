Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 8307D67C05
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 03:18:21 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id m3so836496uge
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Jun 2006 10:17:51 -0700 (PDT)
Message-ID: <528646bc0606081017p3f850933q33a09d62441d5c8b@mail.gmail.com>
Date: Thu, 8 Jun 2006 11:17:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "rakirtley@bellsouth.net" <rakirtley@bellsouth.net>
Subject: Re: A Couple of 2.6/Xilinx Questions
In-Reply-To: <20060608144535.RSPS5063.ibm70aec.bellsouth.net@mail.bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060608144535.RSPS5063.ibm70aec.bellsouth.net@mail.bellsouth.net>
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

On 6/8/06, rakirtley@bellsouth.net <rakirtley@bellsouth.net> wrote:
> All,
>     I've been attempting to get a 2.6 version running on the Xilinx ML403 and only really need the ethernet and compact flash devices at this point.  I've tried versions from mvista, kernel.org, etc; all only have the serial8250 device enabled.  Obviously adding devices is a lot of work and it appears that you all have already made great progress enabling ethernet.
>    Are any of  the advanced versions upon which you all work generally available?  If so could you please provide a location? Apologies in advance for polluting your emailboxes and thanks in advance for any help/pointers that you can provide. I'll be more than happy to share any mods that I make (if any)

Mvista published patches for a TEMAC driver a month or two ago onto
this mailing list.  Last I heard, mvista will be releasing 2.6 support
for the V2/V4 parts by the end of this month.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
