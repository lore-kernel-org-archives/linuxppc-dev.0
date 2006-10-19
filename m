Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id A3A5867BB2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 00:46:45 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so413325ugc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 07:46:43 -0700 (PDT)
Message-ID: <528646bc0610190746i78068543mf343d19167a38f97@mail.gmail.com>
Date: Thu, 19 Oct 2006 11:46:43 -0300
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Roman Fietze" <roman.fietze@telemotive.de>
Subject: Re: status of mpc52xx with arch=powerpc?
In-Reply-To: <200610191149.10873.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<20061019081337.GF6202@localhost.localdomain>
	<200610191149.10873.roman.fietze@telemotive.de>
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

On 10/19/06, Roman Fietze <roman.fietze@telemotive.de> wrote:
> Could you both double check e.g. with Sylvain Munaut at

If Sylvain is around and has available bandwidth, I'm sure he is
monitoring this list.

> There are many drivers (git heads) available already, including IDE,
> FEC, and so on. There's also new BestComm/FEC/IDE code from Dale
> Farnsworth and John Rigby (Freescale) somewhere on the net.

Yes, I'm using those patches; but they don't help with getting the
mpc52xx moved over to arch/powerpc

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
