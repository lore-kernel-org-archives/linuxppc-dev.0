Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id F049DDDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:57:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so433054anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:57:07 -0800 (PST)
Message-ID: <fa686aa40801280757x649874b1l909ae45b2a54b23b@mail.gmail.com>
Date: Mon, 28 Jan 2008 08:57:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/9] 83xx DTS fixes and v1 conversions
In-Reply-To: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/28/08, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> This series incorporates my earlier qe/muram fix before converting
> the existing mpc83xx DTS files to v1 format.  I've also redone the
> mpc834x_mds with the IRQs as decimal as per Kumar's comments and
> re-included that too.  I've kept each board as a separate commit
> in case one of them conflicts with what someone else is working on.
>
> Boards covered are: 8349mds, 8349mitx, 8349mitx-gp, 836x_mds,
> 8323_mds, 8323_rdb, and the 8313_rdb.  Plus a small tweak to the
> sbc8349 (it was already v1 -- but IRQs were in hex.)

Cool!  Want to do the 5200 dts files too?  :-)

/me is lazy

Cheers.
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
