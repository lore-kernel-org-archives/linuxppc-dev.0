Message-Id: <200008060231.WAA22602@mal-ach.watson.ibm.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: Message from Takashi Oe <toe@unlserve.unl.edu>
   of "Sat, 05 Aug 2000 21:15:28 CDT." <Pine.LNX.3.96LJ1.1b7.1000805204429.649H-100000@ofey.earthlink.net>
Date: Sat, 05 Aug 2000 22:31:57 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I would guess that for smaller numbers of cases, GCC is deciding
that it is more efficient to use a series of "if" statements for a
decision tree instead of a switch statement.  You can explicitly code it
as such, e.g.,

if (bi->dispDeviceDepth == 32)
...
else if (bi-dispDeviceDepth == 16)
...
else if
...
else abort();

(BTW you do not provide a default case for some illegal value in your
switch statement.)

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
