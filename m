Message-ID: <3BE657EB.6030006@waitaki.otago.ac.nz>
Date: Mon, 05 Nov 2001 22:12:11 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: Matt Brubeck <mbrubeck@hmc.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound_pmac in 2_4_devel
References: <Pine.GSO.4.32.0111041903030.26186-100000@turing.cs.hmc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Brubeck wrote:

>I found a very audible clicking and popping during audio playback.  This
>is noticeable e.g. when playing normal MP3 files with xmms.  The clicking
>does not occur with the driver in the (non-devel) 2_4 tree.
>
Likewise on my PowerBook G4. Have you looked at the ALSA drivers?
Unfortunatly they (as of 0.9.0beta8a) don't compile against 2.4.14-pre
when I last checked, but I've heard reports of success on earlier
kernels and with earlier ALSA releases.

regards

Bryce.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
