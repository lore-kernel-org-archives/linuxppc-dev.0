Date: Tue, 30 Nov 1999 19:23:09 -0500 (EST)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Real Time response/latency question
In-reply-to: <3843ED00.20D47DF4@netx4.com>
To: Dan Malek <dan@netx4.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9911301917280.1860-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Tue, 30 Nov 1999, Dan Malek wrote:

> 
> Graham Stoney wrote:
> > 
> > Hi folks,
> > 
> > I'm looking at software architecture questions, and wondering how much
> > application domain work I can move out of driver land and into user space,
> 
> I believe this is a good programming practice, and in many
> cases I don't even write a driver when the application is
> allowed to run with root privilege.
I have not looked yet into this section of my own project but I'll have to
eventually so I have a question: how about interrupt? I guess a very
simple driver which kicks some userland waiting thread is good enough in
most cases. Or is there a way to register some userland code?

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
