Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4DD19B6EFE
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 21:15:22 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa41001022118w6b41765ld145c646bfca9423@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	<20100101141205.6F0B13F6FF@gemini.denx.de>
	<fa686aa41001022118w6b41765ld145c646bfca9423@mail.gmail.com>
Date: Sun, 03 Jan 2010 11:15:20 +0100
Message-Id: <20100103101520.D1E7AE34A26@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	linux-kbuild@vger.kernel.org, u-boot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa41001022118w6b41765ld145c646bfca9423@mail.gmail.com> you wrote:
>
> As I said in a previous email; I understand the need for certain
> scenarios, but in the general case it is not the mode that I think
> should be encouraged.  I don't want to merge additional targets for
> .dtb embedded in the kernel image unless absolutely necessary, and I
> want developers to have the mindset that .dtbs should be separate from
> the kernel; and should be quasi-stable (or at least more stable than
> the kernel itself) because I think that multiplatform is important,
> and is going to become more important in the future.
> 
> So I don't want to support it by default; but OTOH, I'm not going to
> actively prevent embedded .dtb blobs either.

But by blocking the addition of such a make target you do actively
prevent this, don;t you?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The years of peak mental activity are undoubtedly between the ages of
four and eighteen. At four we know all the questions, at eighteen all
the answers.
