Mime-Version: 1.0 (Apple Message framework v606)
Message-Id: <2AA74CF2-FF2E-11D7-93F0-000A958557FC@macdiscussion.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@lists.linuxppc.org
From: Mark Guertin <mguertin@macdiscussion.com>
Subject: OF and/or kernel option for ext video on tibook
Date: Wed, 15 Oct 2003 12:39:37 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone

Can anyone help me here, all teh googling I've done has led to no
answers ...

I have a TiBook 550 mhz that had the screen destroyed here at work,
which I've been using as a linux workstation on external video until
recently.  I powered it down for a couple weeks while I was doing other
work, and now I can't get my main video to work on the external
display, it always tries to go to the non existent screen ... maybe the
mboard battery is dying and it reset to defaults in OF ...

Is there a kernel option I can pass at boot to force it to use only the
external video (or mirror, whatever works)?  Or better yet, is there
something I can tell OF to use only this device .. I've tried setting
the screen option several times, but it doesn't seem to pick it up.

Gerk


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
