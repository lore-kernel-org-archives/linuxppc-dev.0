Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by ozlabs.org (Postfix) with ESMTP id 490F9DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:33:37 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1619958ika
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 09:33:36 -0700 (PDT)
Message-ID: <528646bc0704160933o76861f6cqaeac768415f8adb8@mail.gmail.com>
Date: Mon, 16 Apr 2007 10:33:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [RFC] Xilinx SystemACE device driver
In-Reply-To: <4623A523.3040705@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176600194262-git-send-email-grant.likely@secretlab.ca>
	<4623A523.3040705@ru.mvista.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Stefan Roese <sr@denx.de>,
	Rick Moleres <Rick.Moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/16/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Hi Grant,
>
> Grant Likely wrote:
> > Add support for block device access to the Xilinx SystemACE Compact
> > flash interface
>
> Does the driver support 8-bit bus_width?
>
> Just gave the driver a try on ML300, and my first attempt failed.
> Wonder if it's me having done something wrong, or something the driver doesn't
> handle yet.

Doesn't handle it yet, you'll need to add 8-bit access macros to the
top of the file.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
