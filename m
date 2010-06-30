Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C8F54B6EED
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 15:31:55 +1000 (EST)
To: David Daney <ddaney@caviumnetworks.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 4/9] Add Synopsys DesignWare HS USB OTG Controller driver.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4C2A8038.50204@caviumnetworks.com>
References: <12778468223309-git-send-email-fchen@apm.com>
	<12778468233898-git-send-email-fchen@apm.com>
	<12778468231438-git-send-email-fchen@apm.com>
	<1277846824673-git-send-email-fchen@apm.com>
	<20100629231302.7E6E314EBF8@gemini.denx.de>
	<4C2A8038.50204@caviumnetworks.com>
Date: Wed, 30 Jun 2010 07:31:50 +0200
Message-Id: <20100630053150.ACD9A14EBF7@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear David Daney,

In message <4C2A8038.50204@caviumnetworks.com> you wrote:
>
> > Why are you posting this old driver version without trying to sync
> > against our tree which includes a number of fixes - you should know
> > about these.
> >
> 
> This could be a question with an obvious answer, but which tree are you 
> referring to when you say 'our tree'?

git://git.denx.de/linux-2.6-denx.git

Fushen Chen should know this, as the fixes I've mentioned were part
of contract/support work for Applied Micro.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The Wright Bothers weren't the first to fly. They were just the first
not to crash.
