Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 54EC6B6EF4
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 20:50:37 +1100 (EST)
To: Peter Korsgaard <jacmet@sunsite.dk>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <87wrzzpq8c.fsf@macbook.be.48ers.dk>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
	<20100101104449.6DAC63F6FF@gemini.denx.de>
	<87wrzzpq8c.fsf@macbook.be.48ers.dk>
Date: Sun, 03 Jan 2010 10:50:32 +0100
Message-Id: <20100103095032.8F05AE34A26@gemini.denx.de>
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

Dear Peter,

In message <87wrzzpq8c.fsf@macbook.be.48ers.dk> you wrote:
>
>  Wolfgang> Let's make this "uImage.old" (or "uImage.legacy" similar) and
>  Wolfgang> "uImage", then.
> 
> No, that would break stuff for the existing users. The existing format
> make/file names shouldn't change.

Well, with this argument you can block all progress and freeze all
development to some ancient state.

When the arch/ppc => arch/powerpc conversionm was done, we had similar
issues: the new "powerpc" uImages would not work as the old "ppc"
uImages dis, because you also needed the device tree blob, or you had
to use the cuImage files. Note that then the decision was made to
support the _new_ version as the default, using the default name,
which is IMO the Right Thing to do.

> The FIT images could be called fitimage or uImage.new or something.

I disagree. We want to make this the new default, so let's use the
default name for this, and continue to support he legacy image format
using another name.

Also, your approach does not scale. Assume we come up with an even
more advanced image format in the future - how should we name it then?
"uImage.newer" ? "uImage.verynew" ? "uImage.new2" ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The world is coming to an end -- save your buffers!
