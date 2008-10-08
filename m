Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 13A44DE3C5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 03:14:52 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4196375wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 09:14:51 -0700 (PDT)
Message-ID: <fa686aa40810080914n508150bcva235ec85322ff5cf@mail.gmail.com>
Date: Wed, 8 Oct 2008 10:14:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/3] MPC5121 add pci support
In-Reply-To: <77D97C6B-7F07-45AA-98D0-EE4723E2ABAD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
	<77D97C6B-7F07-45AA-98D0-EE4723E2ABAD@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 8, 2008 at 12:20 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 7, 2008, at 2:00 PM, John Rigby wrote:
>
>> The following three patches add pci support for MPC5121
>> These got no NACKs back in August but they were not picked up
>> by anyone either.
>
> I'll look at picking up patches 1/3 and 3/3.  I'll leave 2/3 to Grant.

Kumar, since both 1/3 and 2/3 touch fsl_pci.c, can you please pick up
2/3?  It won't conflict with anything that I'm pushing.  I'll post my
ack-by line.

g.

>
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
