Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <404F421B.2000602@mvista.com>
Date: Wed, 10 Mar 2004 09:28:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Marvell DB64360
References: <010201c40692$51da2820$0400a8c0@portatile>
In-Reply-To: <010201c40692$51da2820$0400a8c0@portatile>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ing.Gianfranco Morandi (LAN) wrote:

>I'm evaluating a new development based on PPC750FX and I would like to check
>if there is some porting on the ELDK 3.0 package.
>
I'll defer to Wolfgang on this one.

>I have also verified what development board could be the best candidate to
>be used as starting point and It seems to be the Marvell DB64360.
>
>Did anybody work on such board?
>
>and
>
>Could anybody suggest me if there is some better reference point?
>
>
There are several emails regarding this in the archives but basically,
right now the linux_2_4_galileo tree on source.mvista.com is the only
tree that I know of with 64360 support publicly available.  Note that
this is an old, dead tree.

I'm currently working on a merged pkg (64260/360/460) for the 2.6 tree
but its not ready.  I don't know if it will be worth back porting to 2.4
b/c that tree is pretty much locked down.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
