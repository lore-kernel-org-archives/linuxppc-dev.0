From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Grimm <joker@cymes.de>,
	PPC-Dev Mailingliste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: muteing speakers if headphones were plugged in?
Date: Tue, 16 Apr 2002 18:30:26 +0100
Message-Id: <20020416173026.16606@smtp.wanadoo.fr>
In-Reply-To: <3CBC59C0.7000505@cymes.de>
References: <3CBC59C0.7000505@cymes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi,
>
>I was asked to built a new feature into pbbuttons: To mute the speakers
>if headphones are plugged in.

It's already implemented at the driver level for some chipsets.

>I don't know where to get the information if headphones are plugged in
>or not, so I had a look into the recent kernel and I saw some code (for
>eg. headphone_intr() ) that seems to do what I am asked for. On the
>other hand the code seems very experimental and not really complete as I
>could see at some comments.
>
>What is the status? Should this feature (muting the speakers ...) be
>part of the kernel or was it only a fast shot to get it work?

It works with recent drivers though only if your chipset is Tumbler afaik.

>I saw the most headphone code within the Tumbler section so I assume
>that it would only work on new TiBooks and iBooks?

Yes.

>Nevertheless is there a method to get the information of the line-in
>jack status from user space?

Not that I know of, but I don't know the OSS API that well, it may
be possible to add this information to what is returned from the driver.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
