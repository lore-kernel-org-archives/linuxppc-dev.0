In-Reply-To: <14306.21109.970188.33759@cpu.wpi.edu>
Date: Fri, 17 Sep 1999 18:10:56 +0200
To: Josh Huber <huberj@WPI.EDU>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Lombard shuts itself off
Message-Id: <19990917181056.027066@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 17, 1999, Josh Huber <huberj@WPI.EDU> wrote:

>It's almost as if the battery gets disconnected sometimes:
>I put the machine to sleep in MacOS, unplug the power strip, put it in
my case,
>and walk around with it for a while, open the case up, and...oh look at that
>the led isn't blinking any more!
>
>Then, the same thing started happening with linux...
>
>It gets to a point where I can't get the machine to boot again without
putting
>the power plug back in.
>
>I was suspicious of a faulty battery bay, so I (temporarily) moved the
battery
>over to the other bay last night -- we'll see how that works.

I have a similar problem with my wallstreet. It seems to survive quite
well when travelling with in bag, but when working with it on my knees, A
brutal move sometimes disconnects the battery. 

There is still a possibility of a problem with PMU communication. This
beast is quite sensitive to various timing issues, and when something
goes wrong, it shuts the machine down abruptly.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
