Message-ID: <3A7855C1.C667B03E@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 19:13:21 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Josh Kindler <josh@antihype.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Quick Question
References: <B69CD9B5.23C9%josh@antihype.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Kindler wrote:
>
> The LiVid GATOS project website (linuxvideo.org/gatos) says that there are
> two versions of the Rage Mobility.
> Can you tell me which one is in my Pismo Powerbook (2000 model).

michdaen@pismo:~> lspci |grep VGA
00:10.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x
(rev 02)


This is the Rage128 based one.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
