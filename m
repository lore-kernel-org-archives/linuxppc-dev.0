From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	"David N. Welton" <davidw@dedasys.com>
Subject: Re: sleep: trackpad settings, screen blanking
Date: Wed, 21 Nov 2001 19:23:24 +0100
Message-Id: <20011121182324.24462@mailhost.mipsys.com>
In-Reply-To: <87n11g888h.fsf@dedasys.com>
References: <87n11g888h.fsf@dedasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>It's the "stable" kernel from the ftp site.

Hrm... which ftp site ?

>> >2) Trackpad settings aren't restored (or saved beforehand?) after
>> >   sleep.  Same questions apply.
>
>> That's normal for now.
>
>I see... is anyone working on it? "KOBAYASHI R. Taizo" sent me a patch
>that he says does it...  I suppose I don't have the time in any case
>(nor much knowledge).

There was some code to do that in pmud afaik, but I think it was
broken in subtle ways and got disabled. Just run the trackpad tool
again from your /etc/pwrctl script.

For 2.5, I'm thinking about doing a /proc/bus/adb, with all the
available config infos (Fn key behaviour, trackpad setting, maybe
other things on non-Apple devices like HW button mapping on some
third party mice when we know how to do it).

At this point, I expect those infos to be backed up accross ADB
resets.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
