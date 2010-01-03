Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id A0C0FB6EEB
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 16:11:18 +1100 (EST)
Received: by ywh36 with SMTP id 36so14563186ywh.15
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 21:11:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091231224439.AF5353F6D1@gemini.denx.de>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Jan 2010 22:10:56 -0700
Message-ID: <fa686aa41001022110m5767925bqf8f6d3eadf965d6d@mail.gmail.com>
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

On Thu, Dec 31, 2009 at 3:44 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com> =
you wrote:
>>
>> IIRC, uImage.fit.initrd.% should appear before uImage.fit.% in the
>> Makefile so that make behaves more consistently. =A0Speaking of which,
>> the number of '.' in the name is getting rather large. =A0Would you
>> consider using 'fitImage' instead of 'uImage.fit'?
>
> Why chose a different name at all? We could still call it "uImage",
> meaning "U-Boot image" - U-Boot is clever enought o detect
> automatically if we pass it an old style or a fit image.

Simply because arch/powerpc/boot/Makefile needs different target names
to decide which kind of image to build.  I don't care much about the
name, it can always be renamed at install time, but I do care that the
make build targets are sane.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
