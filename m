Message-ID: <37A18EA3.7E0ED880@mitre.org>
Date: Fri, 30 Jul 1999 07:38:11 -0400
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: Takayuki Yamaizumi <zumi@yamato.ibm.co.jp>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: G3 Upgrade Questions....
References: <XFMail.990728151208.jeremy@goop.org> <lcr9lsqd0d.fsf@yamato.ibm.com> <37A01A3D.E9A83C73@agelectronics.co.uk> <lcemhq29xv.fsf@yamato.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takayuki Yamaizumi wrote:
[...]
>   I've never checked that document, so I download it (but, today I

The code listed in that app note does not seem to include any bit
reversals (did I miss something?) and it works fine (the temperatures
are linear, just 20 degrees too high) on a 740 card here.

I used the code for a different reason (it seems that the board fails
right when the TAU reads between 66 and 70 degrees C) but I held off on
turning it into a kernel patch because I can see it now -- as soon as a
patch gets into the 2.2 kernel tree, people are going to start hitting
the list with questions like "why does my computer think that it's 70 C
in here?". At the very least, whoever puts the code in the kernel should
take a hint from Motorola's code and also spit out whether the value has
been calibrated or not (compile-time option? or an OF variable?
thoughts?)

--Charles Lepple
clepple@mitre.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
