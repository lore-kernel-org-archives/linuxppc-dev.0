Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 8F92067B8F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 01:38:10 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1653166ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 08:38:08 -0700 (PDT)
Message-ID: <528646bc0608210838p4071f9eeie560fbba18ae2b3d@mail.gmail.com>
Date: Mon, 21 Aug 2006 09:38:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wade Maxfield" <wmaxfield@gmail.com>
Subject: Re: PPC beginner questions
In-Reply-To: <45a1b53e0608210759p270c2f8dy694e91f409d57729@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
	<528646bc0608210714g51928043lb729e80bda753d4d@mail.gmail.com>
	<45a1b53e0608210759p270c2f8dy694e91f409d57729@mail.gmail.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/21/06, Wade Maxfield <wmaxfield@gmail.com> wrote:
> Hi Grant,
>
>   Thanks!
>
>   in*
>   out*
>
>   I'm assuming inb() outb(), inw() outw()??  I've been googling and have
> come up short with info that makes sense. It is almost all x86 centric.

in_8, in_be16, in_be32, out_8, out_be16, out_be32 for big-endian
device registers
in_8, in_le16, in_le32, out_8, out_le16, out_le32 for little endian
device registers

>
>   We will not be porting these drivers, this is a captive box internal use
> only, limited run (200 units or so), 10 to 20 year lifespan once it hits the
> field.
>
>   So, the virtual address I get back can be used directly.  Can I cast to
> short * and long * and char *?

heh, yes you can; but if your writing new code why not use good
practice from the start?  :)

>
>    I apologize for the basic questions, but I expect this will be a final
> question for quite some time.

No worries; ask away!

Cheers,
g.


BTW, when on the mailing list, please use "reply to all" and put your
comments below what you're commenting on.  This keeps the thread on
the mailing list for others to see, and it makes it blatentely obvious
what you're commenting on.  (just general list-etiquette)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
