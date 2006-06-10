Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id D01F867C83
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 09:08:49 +1000 (EST)
Subject: Re: sleep / wake-up
From: Lee Revell <rlrevell@joe-job.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0606110027010.16586@poirot.grange>
References: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
	<53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
	<Pine.LNX.4.60.0606110027010.16586@poirot.grange>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 19:02:10 -0400
Message-Id: <1149980531.14253.92.camel@mindpipe>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 2006-06-11 at 00:41 +0200, Guennadi Liakhovetski wrote:
> On Sat, 10 Jun 2006, Jon Scully wrote:
> 
> > Also, here's an article (just about 4 days old):
> > http://www.linux.com/article.pl?sid=06/05/24/1716222
> > (I thought the subject sounded familiar ;-)
> 
> Ok, thanks for both replies. That's a good start already! But this is all 
> about __software__ suspend. But aren't some other "hardware" suspend-modes 
> also available on ppc, like suspend-to-RAM? For example, on my system I 
> could say quite a bit of power by stopping the HD, switching off 
> USB-ports, eth, and then putting the CPU to sleep? Would all this be 
> doable by just performing those steps and then clocking the CPU down?
> 

Did you read the article?

"ACPI state S3 -- also know as Suspend-to-RAM -- is the state where
everything in the system enters a low-power state except for RAM, which
consumes a small amount of power in order to retain its contents, so
that upon resuming, everything is loaded back from the memory and all
running applications are restored immediately."

> I must admit, I don't understand the whole idea behind suspending at all. 
> What happens to all applications that went to sleep for 1 second and wake 
> up 2 days later? What about all network connections? timeouts? I have to 
> read some basics...

It's insanely difficult and complicated.  Every single driver and kernel
subsystem has to be changed.  Zillions of man-hours have gone into
getting suspend to work on Linux and it's still not there...

Lee
