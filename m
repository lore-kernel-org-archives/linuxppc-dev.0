Message-Id: <199908301312.IAA02257@mailhub.iastate.edu>
Date: Mon, 30 Aug 1999 08:16:18 -0500
Subject: Re: Communicator Crashes X II
From: "Kevin Puetz" <puetzk@iastate.edu>
To: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>, lambert@jeol.com,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A serial port buffer issue is behind the 'FB. overflow ####' crash, also 
often exposed during VT changes while PPP is running.

This could be related. Or it might not. I really don't know the subsystem
well enough to say.
>From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
>To: lambert@jeol.com, linuxppc-user@lists.linuxppc.org,
linuxppc-dev@lists.linuxppc.org
>Subject: Re: Communicator Crashes X II
>Date: Mon, Aug 30, 1999, 12:07 AM

> Well I may have some more news about this problem...
>
> Fisrt I just locked up using lynx!!!  Box rebooted after? 1min?  Again proves
> this is not Netscape, nor a font issue etc.

Yikes! When lynx locks up the whole box, that would rule out an X-related
instability... Were you in an xterm or straight console? Was X running on
another VT?

> I had 2 hard crashes one right after the other.  The first after having set up
> my printer on my other serial port.  One thing I did during this was to unplug
> my Pilot cradle and plug in my Printer.  The two crashes occured shortly after
> that.  Could this be a problem with the serial code/our hardware.  (PS I know
> that you are not supposed to hot swap the serial ports.  I just have gotten
> into bad habbits over the years. ;-)

I thought serial ports were supposed to be safe :-)
Only buses (like ADB/parallel) were supposed to be problematic.

> I don't know about others but my 8500 has been moved from dorm room to home
> and around more times that I can think.  I have plug/unpluged the serial port
> more time that I can think.  A couple of us have said they use Cable modems
> and I am going to DSL as soon as Pac Bell can get out here to hook me up.
> This tends to rule out the networking code...

Except that at least one person with a crashing COmmunicator does not use
PPP.

> So what about the serial ports.  I am thinking the problem may lie there.
> Does anyone else have thoughts/info which might support this theory.
>
> Thanks
> Ira Weiny


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
