Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <12605.216.110.51.8.1080057816.squirrel@www.orkun.us>
In-Reply-To: <4057CCD40003780D@mssbzhh-int.msg.bluewin.ch>
References: <4057CCD40003780D@mssbzhh-int.msg.bluewin.ch>
Date: Tue, 23 Mar 2004 10:03:36 -0600 (CST)
Subject: Re: IBM 440GX, Ocotea...
From: "Tolunay Orkun" <listmember@orkun.us>
To: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The Ocotea 440GX board seems to be supported in the
> "linuxppc_2_4_devel" tree. Is this board configuration
> up-to-date and still maintained?
>
> A more up-to-date implementation seems to be in the
> "linuxppc-2.4" tree. Are there some open issues or known
> problems? I realized that the L2 cache has been disabled
> recently:

Regarding penguinppc.org BitKeeper trees, I was told that
linuxppc_2_4_devel tree is now dead and all commits are done against
linuxppc-2.4. Perhaps maintainers can clarify that in more detail. My
405GP snapshot is coming from linuxppc-2.4.

There is also another linuxppc_2_4_devel tree maintained by DENX. I don't
know the sync state between these two trees. It is my understanding that
DENX tree has some fixes that might not be in the BK trees.

IMHO, the community would be best served by single set of sources...

Best regards,
Tolunay Orkun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
