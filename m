To: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IRDA support
References: <20010503102914.A4411@gehtnix.fernuni-hagen.de>
From: Daniel Berlin <dan@cgsoftware.com>
Date: 03 May 2001 03:42:44 -0400
In-Reply-To: <20010503102914.A4411@gehtnix.fernuni-hagen.de> (Uwe Steinmann's message of "Thu, 3 May 2001 10:29:14 +0200")
Message-ID: <8766fianez.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Uwe Steinmann <steinm@majestix.fernuni-hagen.de> writes:

> Hi,
>
> short question. Do any of the recent kernels support IRDA on a
> Pismo?
Nope.

> If no, what needs to be done to make it work?

Get it to actually turn it on properly, i would imagine.
it times out trying to send the setup bytes, or something like this.

I actually cared about this for 10 or 20 minutes, and looked at the
openfirmware code, and it looked like it was remarkably simple to turn
the led on and off, so i wouldn't imagine fixing it is a large job.

>
>   Uwe
> --
>   Uwe.Steinmann@fernuni-hagen.de
>   Tel: +2331 987 4528    Fax: +2331 987 375
>

--
"Last time I went skiing, I had to get up at 5:00 in the morning.
I knew I couldn't do that, so I slept with my skis on.  My ride
came at 5:30 in the morning, couldn't wake me up so he carried
me out of the house, put my skis on the roof rack of the car,
and drove to the mountain.  Seventeen miles later, I woke up out
of this incredibly bizarre dream that I was skydiving
horizontally.  I'm sure this has happened to you.
"-Steven Wright

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
