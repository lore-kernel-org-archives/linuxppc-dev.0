Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 633A067C85
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:16:57 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so281155ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Dec 2006 15:16:55 -0800 (PST)
Message-ID: <528646bc0612061516q558a3bb4x5f5f72646d27b4b8@mail.gmail.com>
Date: Wed, 6 Dec 2006 16:16:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Timur Tabi" <timur@freescale.com>,
	"linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: Re: QE includes in lite5200.c
In-Reply-To: <4577264E.3080406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4577264E.3080406@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/6/06, Timur Tabi <timur@freescale.com> wrote:
> Grant,
>
> I see your name is attached to arch/powerpc/platforms/lite5200.c, so I presume
> you're the one who moved it from arch/ppc to arch/powerpc.  In that move, the
> following two lines were added to lite5200.c:
>
> #include <asm/qe.h>
> #include <asm/qe_ic.h>
>
> I don't think the 5200 has a QE (QUICCEngine), and I don't see any reference to
> QE code in lite5200.c.  If I comment out these two lines, the code still compiles.
>
> Do you know of any reason why I shouldn't submit a patch that removes those two
> lines from arch/powerpc/platforms/lite5200.c?

Go to it; I don't know why those includes got added.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
