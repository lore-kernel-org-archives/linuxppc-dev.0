Date: Sat, 1 Dec 2001 02:38:48 -0800
Subject: Re: Byte order in sound drivers
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
From: Jeff Koftinoff <jeffk@jdkoftinoff.com>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3C08ADE6.8030004@waitaki.otago.ac.nz>
Message-Id: <9A5DA94E-E647-11D5-8040-003065709198@jdkoftinoff.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, December 1, 2001, at 02:16 AM, Bryce McKinlay wrote:

>
> It seems that some of the newwer media player applications (including
> mplayer and the latest xmms from CVS) swap the byte order of sound
> samples before playing them on PPC, and this results in nothing but
> static from both the dmasound and usb audio drivers.
>
> Is this because the sound driver perhaps already doing endian-swapping,
> and can I disable it? Are these applications correct to want to convert
> samples into the native endian-ness?
>
> I'm using a 2.4.14 benh kernel.
>
> cheers
>
> Bryce.
>
>

XMMS has endian problems with wav files, but not mp3 files - It is
listed as a bug as well for sparc.  The problem solely lies with
applications that are written incorrectly.

jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
