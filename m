Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0099.hostedemail.com
 [216.40.44.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytWjn2N14zDrpH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 23:23:56 +1100 (AEDT)
Message-ID: <1512735829.1845.15.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon: use ARRAY_SIZE on various array sizing
 calculations
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh
 <bsingharora@gmail.com>,  Colin King <colin.king@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, kernel-janitors@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 08 Dec 2017 04:23:49 -0800
In-Reply-To: <87efo5h1yh.fsf@concordia.ellerman.id.au>
References: <20171207110134.22566-1-colin.king@canonical.com>
 <CAKTCnzmNKtg1morOPS7D3iGHFxZxd1uioex1eGtChBVppcctKA@mail.gmail.com>
 <87efo5h1yh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-08 at 22:51 +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > On Thu, Dec 7, 2017 at 10:01 PM, Colin King <colin.king@canonical.com> wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Use the ARRAY_SIZE macro on several arrays to determine their size.
> > > Improvement suggested by coccinelle.
> > 
> > This file is taken from binutils and re-licensed. Keeping the file
> > as-is helps apply newer patches easily on top as opposed to redoing
> > the changes. I would prefer not to move to ARRAY_SIZE and stick to
> > what's already in the file.
> 
> Yep.
> 
> Thanks but no thanks on this one Colin.
> 
> Is there a checkpatch blacklist anywhere? So we don't keep discovering
> things in this file that need to be fixed?

Nope.  Besides, this came via a coccinelle suggestion.

What might be useful is a generic marker somewhere in
a file that shows the file as a generated file and
indicates the file should not otherwise be modified.
