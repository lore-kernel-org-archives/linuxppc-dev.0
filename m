Message-ID: <20000321123522.15129.qmail@web112.yahoomail.com>
Date: Tue, 21 Mar 2000 04:35:22 -0800 (PST)
From: Michel "D?nzer" <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: XFree4 w rage128
To: georges Harrisson <georges.harrisson@caramail.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- georges Harrisson <georges.harrisson@caramail.com> wrote:

> I just asked for 640x480@60 hz with the same horizontal
> and vertical ranges I used for XF 3.3.5.

What are those ranges? Does it really reject the modes due to them, or what
does the log say? (The reason is in brackets)

> I am using aty128fb as a console driver, but I am expecting
> the r128 driver to work and not the fbdriver for XFree.

It does, according to lots of people.

> I said that when my console is driven with offb, it goes
> further and my screen is detected, but XFree ends with a
> segmentation fault without warning.
> What is wrong with aty128fb?

Why do you think something's wrong with it? At least the server doesn't crash
with it, so I'd rather ask what's wrong with offb...

> Does it conflicts with the r128 driver, preventing it from doing a good
> detection ?

On the contrary, AFAIK it's needed for the r128 driver to work on Macs yet.

> It seems that it is not X but the r128 driver who discards all the video
> modes, since it disables even modes I didn't specified in my XF86Config
> file.

Those are predefined modes, a new feature of 4.0 .

That reminds me: Have you defined your wanted mode yourself? If so, you could
try changing its name, preventing interference with the predefined modes.


Michel


PS: Please read RFC 1855 (e.g. at
http://www.cybernothing.org/cno/docs/rfc1855.html)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
