Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196]) by ozlabs.org (Postfix) with ESMTP id D41BAB6EEB
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 16:14:04 +1100 (EST)
Received: by yxe34 with SMTP id 34so12685314yxe.16
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 21:14:02 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100101104449.6DAC63F6FF@gemini.denx.de>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
	<20100101104449.6DAC63F6FF@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Jan 2010 22:13:42 -0700
Message-ID: <fa686aa41001022113o46bad9d2xf6c026f5fa3e8677@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Jan 1, 2010 at 3:44 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Peter,
>
> In message <1262301038.29396.137.camel@localhost.localdomain> you wrote:
>> What do you think about changing the U-Boot documentation to rename
>> those 2 image types to:
>> 1 uImages
>> 2 FIT Images
>
> Let's make this "uImage.old" (or "uImage.legacy" similar) and
> "uImage", then.

I'm not interested in renaming the target name for the current uImage
format.  I think it will cause too much breakage and pain to do so.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
