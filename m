Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 632B9DDEC4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 05:52:07 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1891859ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Jan 2007 10:52:05 -0800 (PST)
Message-ID: <528646bc0701031052k7893c84cxcb3d5b1262a585e6@mail.gmail.com>
Date: Wed, 3 Jan 2007 11:52:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: [PATCH] disable PReP and EFIKA during make oldconfig
In-Reply-To: <20070103173356.GA26130@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070103173356.GA26130@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/07, Olaf Hering <olaf@aepfle.de> wrote:
>
> New boards should not be enabled per default.
> Disable EFIKA and PReP per default.
> Anyone who really needes the new code can enable it during make oldconfig.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

In fact, I think this sort of stuff should also go in a sub menu.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
