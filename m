Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id E4960DDF10
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:48:23 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so288237nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 08:48:22 -0700 (PDT)
Message-ID: <528646bc0703160848n92a7112y30a3091b6ae5320b@mail.gmail.com>
Date: Fri, 16 Mar 2007 09:48:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] [004/006] Removed config options that we don't
	support in embedded6xx
In-Reply-To: <Pine.LNX.4.64.0703161023390.9740@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
	<Pine.LNX.4.64.0703161023390.9740@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/16/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> When we started arch/powerpc we duplicated a number of config options from arch/ppc
> for various platforms that are supported.  Now that we actually support a few
> platforms, remove all the ones that haven't been moved over.  Additionally, this
> cleanup moved the 82xx/PQ2 options over into arch/powerpc/platforms/82xx/Kconfig
> where they belong.  It also killed GEN550 which doesn't exist in arch/powerpc.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
