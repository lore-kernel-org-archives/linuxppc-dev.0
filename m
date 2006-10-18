Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id D472767BE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 23:52:36 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so158254ugc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 06:52:35 -0700 (PDT)
Message-ID: <528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
Date: Wed, 18 Oct 2006 07:52:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: status of mpc52xx with arch=powerpc?
In-Reply-To: <20061018130628.GE6202@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061018130628.GE6202@localhost.localdomain>
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

On 10/18/06, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Is someone working on this already?
>
> There are some Kconfig entries, but there seems to be no code, at least
> not in vanilla.

I'm slowly working on it.  I've got a .dts written and I've got u-boot
w/ the fdt patches running on the board.  I need to port the 52xx PIC
driver into arch/powerpc before I attempt to boot.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
