Message-ID: <17B78BDF120BD411B70100500422FC63079F62@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'Dan Malek'" <dan@netx4.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux 2.3.99-pre5 fail on PowerPC 823, and work on PowerPC 74
	0
Date: Wed, 26 Apr 2000 10:12:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm new to Linux PPC823, the last version I can get running properly on my
board
is linux 2.3.18 modified for PPC860. I don't know the last standard 2.3
linux
working properly on this architecture. Starting with a recent and functional
version
is probably the easy way to find the bugs. I can't also get the BDM working
with
linux, linux crash randomly when I use it. I don't see a simple method to
debug linux, other than adding kgdb support.
If you have an idea of what kind of bug is present here, I can probably do
something and have an idea to start.


Patrick LERDA


> -----Message d'origine-----
> De:	Dan Malek [SMTP:dan@netx4.com]
> Date:	mardi 25 avril 2000 18:52
> À:	Patrick Lerda
> Cc:	'linuxppc-embedded@lists.linuxppc.org';
> 'linux-kernel@vger.rutgers.edu'
> Objet:	Re: Linux 2.3.99-pre5 fail on PowerPC 823, and work on
> PowerPC 740
>
>
> Patrick Lerda wrote:
> >
> > Linux seems to boot on PPC823, but no executable seems to be executed
> > properly,
>
> Yes, I know.  I have been working on it for a long time.  I have
> been distracted to get other things done in 2.3.99, and now I am
> back to it.
>
> > A bug specific to the PPC823 (PPC860 ?) seems to be present here. If you
> > have an idea how to fix it.
>
> So, what are you doing with your time?
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
