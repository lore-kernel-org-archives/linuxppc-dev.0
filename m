Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 60691B6EF0
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 16:24:10 +1100 (EST)
Received: by gxk28 with SMTP id 28so7790430gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 21:24:09 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100101141840.D6C273F6FF@gemini.denx.de>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301457l704c324bk511a207d07218525@mail.gmail.com>
	<20100101141840.D6C273F6FF@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Jan 2010 22:23:49 -0700
Message-ID: <fa686aa41001022123v557f7a46pac2be0b12d4ba297@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: Add support for creating FIT uImages
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

On Fri, Jan 1, 2010 at 7:18 AM, Wolfgang Denk <wd@denx.de> wrote:
>> Rather than adding new paths to arch/powerpc/boot/wrapper, I would
>> rather see a new script used for generating FIT image that isn't
>> complicated by all the current wrapper cruft. =A0Also, the Makefile rule
>> doesn't need to depend on $(wrapperbits) which means faster build
>> times when only building uImages.
>>
>> Bonus points if you also convert the uImage target to use the new
>> script; but I'm not demanding that you do that yet.
>
> I think if this is handles in a separate script, the legacy uImage
> support must be handled in this new script, too. Otherwise it would be
> too difficult to understanmd the relation of the two image formats.

I'm fine with this.  But if I receive a patch that does one and not
the other, I'll probably still merge it.  :-)

>> Finally, you need to add documentation about the new target to
>> Documentation/powerpc/bootwrapper.txt.
>
> Let's keep in mind that the uImage formats (both the old legacy and
> the new FIT format) are inherently architecture independent. We want
> to use this same mechanism for example on ARM, and on other
> architectures as well.

That's fine, but Documentation/powerpc/bootwrapper.txt happens to also
be the place that documents how the boot image creation on
arch/powerpc works.  I'm happy for the text about uImage and fitImage
to make reference to a different Documentation file or URL.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
