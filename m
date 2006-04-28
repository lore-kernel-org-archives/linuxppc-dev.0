Return-Path: <penberg@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id B0CBC679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 16:32:41 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id z3so1841074nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:32:40 -0700 (PDT)
Message-ID: <84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
Date: Fri, 28 Apr 2006 09:32:40 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Heiko J Schick" <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
In-Reply-To: <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4450A176.9000008@de.ibm.com>
	<20060427114355.GB32127@wohnheim.fh-wedel.de>
	<1146177388.19236.1.camel@localhost.localdomain>
	<6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Heiko,

On 4/28/06, Heiko J Schick <info@schihei.de> wrote:
> The problem I see with pr_debug() is that it could only activated via
> a compile flag. To use the debug outputs you have to re-compile /
> compile your own kernel.

Do you really need this heavy debug logging in the first place? You
can use kprobes for arbitrary run-time inspection anyway, so logging
everything seems wasteful.

                                             Pekka
