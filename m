Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id EC8DEDDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 02:50:04 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so459495ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:50:02 -0800 (PST)
Message-ID: <528646bc0701110750m15cd0f01xe014f75a2c9db625@mail.gmail.com>
Date: Thu, 11 Jan 2007 08:50:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add restart function for mpc52xx
In-Reply-To: <20070111152137.GG11226@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> BTW the watchdog timer is only implemented for gpt0. Is it guaranteed
> that I get gpt0 with mpc52xx_find_and_map("mpc52xx-gpt")? As long as
> all flat trees start with gpt0 I guess yes.

No, you cannot make this assumption.  There are no guarantees on order
that nodes are found.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
