Date: Mon, 20 Sep 1999 21:18:03 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Compiling 2.3.18
In-reply-to: <37E5B2EA.9C266862@netx4.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9909202105240.836-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Mon, 20 Sep 1999, Dan Malek wrote:

> 
> > I downloaded 2.3.18 from edge.kernelnotes.org and I am able to compile
> > (after fixing one of the Config.in file).
> 
> This looks like a mirror, so it is likely up to date.  What
> was the problem with Config.in?

it was with the drivers/char/Config.in. Thew problem was a missing ] in
an if statement, unfortunately, I do not remember which line ... :-( Next
time, I'll take notes. Unless I send the file to you so you could do
a diff.

> 
> > Could it be a problem with Dave's tar (as for fadsrom.tar)?
> 
> I don't understand why some people have problems with this file.
> I continually download and extract it just fine on any of my
> Linux machines.  What are you using?
> 
I had the same problem with fasdron.tar.gz (or tgz...), At that
time, I had tried both RH6.0 on a Pentium and R5 on a PowerMac
(but I guess the tools are from the same sources anyway). This time
it was on the PowerMac. But, anyway, I avoided the problem by
having drivers/Makfile not to compile the drivers/sound directory
if CONFIG_SOUND is not set. I added an ifdef statement.

> 
> I usually put something there as a convenience for people that
> can't get CVS access through a fire wall.  It represents my
> source tree, which is known to build, just before I make CVS commits.
> 
> 

if I understand well, right after your local source tree, CVS is the most
up to date. I never used it and I am not behind a firewall, where are the
instructions on how to use it, i.e. do you have an URL?


Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
