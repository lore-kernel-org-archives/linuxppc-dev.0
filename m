Return-Path: <mcgrof@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20100915193926.ae2fe838.sfr@canb.auug.org.au>
References: <1284495763-7506-1-git-send-email-arnd@arndb.de>
	<20100915193926.ae2fe838.sfr@canb.auug.org.au>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Wed, 15 Sep 2010 09:06:25 -0700
Message-ID: <AANLkTimCsuTXM3e0D8zPEsugd2W9c7ziTK+Xx2wmkJb0@mail.gmail.com>
Subject: Re: [PATCH 00/15] change default_llseek action
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: Samuel Ortiz <samuel@sortiz.org>, Arnd Bergmann <arnd@arndb.de>,
	David Airlie <airlied@linux.ie>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Tony Lindgren <tony@atomide.com>, Julia Lawall <julia@diku.dk>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 2:39 AM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Arnd,
>
> On Tue, 14 Sep 2010 22:22:28 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Stephen, please add
>> git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arnd/bkl.git llseek
>
> Added from today.
>
> Thanks for adding your subsystem tree as a participant of linux-next. =C2=
=A0As
> you may know, this is not a judgment of your code. =C2=A0The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
>
> You will need to ensure that the patches/commits in your tree/series have
> been:
> =C2=A0 =C2=A0 * submitted under GPL v2 (or later) and include the Contrib=
utor's
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by,

I should note this should say the code should be GPL-compatible, it
doesn't need to be GPLv2 (or later). Furthermore the contributors of
the subsystem respect the individual licenses of the files through the
Developers Certificate of Origin, which tells the developers what the
meaning of Signed-off-by means.

  Luis
