From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: mort@bork.org, a.aribaud@giat-industries.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded initrd with static programs
Date: Tue, 23 Dec 2003 11:46:02 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F677AgDVZ17iy50006117e@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>It really depends on how many apps you're including.  If you only need
>one app then copying all of glibc in is a waste.  If you've got a bunch
>of apps then it's probably better to copy on the shared libs.
>
>On the other hand, if you can get all your apps to compile against
>uClibc (or one of the other small libs replacements) then you'll be much
>better off.  glibc is huge.
>
>mh

I only intend to use a very small set of tools to accomplish what I want to.
So I figured I didn't need to bother with the shared libraries. And having
finally gotten all the stuff I needed statically compiled and working, I'm
pretty happy with it. :)

_________________________________________________________________
Get dial-up Internet access now with our best offer: 6 months @$9.95/month!
http://join.msn.com/?page=dept/dialup


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
