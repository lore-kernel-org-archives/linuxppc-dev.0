Date: Fri, 20 Jul 2001 16:09:41 +0100
Subject: Re: Video acceleration on IMSTT with bk (and Ben's) 2.4.7-pre6
	 kernel
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010720151155.4DB2E2EFEC@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Fri, Jul 20, 2001, Hollis Blanchard wrote:
> On Fri, Jul 20, 2001 at 11:49:30AM +0100, Iain Sandoe wrote:
>>
>> > Other symptom is that the splash screen #cpus penguin is missing it's
>> > background.
>>
>> this symptom remains (as does missing graphics on the redhat logo etc. on
>> the KDE2 login splash screen).
>
> This symptom is because the penguin logo changed recently.

Ah...

> However, missing graphics in X sound like either misconfiguration or a bug.

well, it's been there ever since I got IMSTT acceleration working (Xpmac) -
the setup, otherwise, is the same as on my other machines (atyfb).

**Only** seems to happen on the KDE splash/login screen (otherwise we seem
to be OK).  Haven't tried other desktops/things that write directly to the
root window (which, I guess, is the difference).

When the system is first brought up the RedHat logo is all black ... as is
the other icon (the login button)...  when you subsequently log out of X
these two items are filled with colour-noise.

I've a feeling it might be a known bug - but can't find a reference to the
mail describing it.  It's not a major problem - just slightly naff-looking.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
