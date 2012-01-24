Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 39BD1B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 10:01:57 +1100 (EST)
Message-ID: <1327446104.19850.45.camel@pasglop>
Subject: Re: [PATCH] powerpc/85xx: fix build failure from p1022 in SMP
 defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 25 Jan 2012 10:01:44 +1100
In-Reply-To: <C8785E6B-CA31-4B61-91F5-97BEAE30D2E9@kernel.crashing.org>
References: <1327157528-12312-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLrjismj5PBfm=3LcVtC7pL4EXkt+JGKQNUuSJu1OU68MA@mail.gmail.com>
 <C8785E6B-CA31-4B61-91F5-97BEAE30D2E9@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-24 at 16:55 -0600, Kumar Gala wrote:
> Ben just missed my pull request with it before 3.3-rc1.  Should get
> into rc2 or I'll have to get someone in ozlabs to beat ben for me ;)

Working on it :-)

Cheers,
Ben.
