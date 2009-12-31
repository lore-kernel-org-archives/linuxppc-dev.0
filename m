Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BF3A31007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 09:44:48 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
Date: Thu, 31 Dec 2009 23:44:39 +0100
Message-Id: <20091231224439.AF5353F6D1@gemini.denx.de>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com> you wrote:
>
> IIRC, uImage.fit.initrd.% should appear before uImage.fit.% in the
> Makefile so that make behaves more consistently.  Speaking of which,
> the number of '.' in the name is getting rather large.  Would you
> consider using 'fitImage' instead of 'uImage.fit'?

Why chose a different name at all? We could still call it "uImage",
meaning "U-Boot image" - U-Boot is clever enought o detect
automatically if we pass it an old style or a fit image.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If the odds are a million to one against something occuring,  chances
are 50-50 it will.
