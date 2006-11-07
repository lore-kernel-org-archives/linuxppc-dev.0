Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 1D36467CAE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 03:30:22 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1065725ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2006 08:30:21 -0800 (PST)
Message-ID: <528646bc0611070830u2d490d79v5843de918c54b05f@mail.gmail.com>
Date: Tue, 7 Nov 2006 09:30:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
In-Reply-To: <455063C6.6070205@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200611071040.kA7Aeea6006482@post.webmailer.de>
	<455063C6.6070205@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, sven@genesi-usa.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/7/06, Sylvain Munaut <tnt@246tnt.com> wrote:
> Nicolas DET wrote:
>
> > This patch add MPC52xx Interrupt controller for ARCH=powerpc.
> >
> > It includes the main code in arch/powerpc/sysdev/ ad well as an header file in
> > include/asm-powerpc.
> >
> > The header file has now distinct section for the struct and the IRQ mapping/enconding define
> >
> > Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> Acked-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
