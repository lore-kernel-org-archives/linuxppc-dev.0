Message-Id: <200003211928.UAA20238@denx.local.net>
To: Don Holmgren <djholm@fnal.gov>
cc: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root nfs boot problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Mar 2000 11:28:31 CST."
             <Pine.SGI.3.95.1000321111628.2421C-100000@hppc.fnal.gov>
Date: Tue, 21 Mar 2000 20:28:53 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.SGI.3.95.1000321111628.2421C-100000@hppc.fnal.gov> you wrote:
>
> I don't believe the "neighbour table overflow" errors are the problem.  I
> get them frequently but otherwise have success.

I have never seen such errors when the ethernet  inrface  is  working
correclty.

> It looks like a problem on your nfs server.  The "unable to get nfsd port
> number from server" and "unable to get mountd port number from server"
> messages indicate that at minimum, the portmapper is not running on your
> server.  Perhaps mountd and/or nfsd are also not running.

Well, IMHO it's more likely that no packets were  ever  sent  to  the
ethernet  at  all.  This  type  of problemppens for instance when the
Transmit Enable signal is not asserted.

It might be useful to check with a sniffer if the box is transmitting
at all...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't put off for tomorrow what you can  do  today,  because  if  you
enjoy it today you can do it again tomorrow.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
