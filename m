From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <yellowdog-devel@lists.yellowdoglinux.com>,
	Ani Joshi <ajoshi@shell.unixbox.com>,
	"Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: new G4 dual 1 gig is here - how to install?
Date: Sat, 16 Feb 2002 20:24:47 +0100
Message-Id: <20020216192447.9676@smtp.wanadoo.fr>
In-Reply-To: <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
References: <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>BTW I just finished building XF4.2.0 in under 45 min from scratch with
>just one CPU on my new box and fired it up and it works just fine out of
>the box.
>
>We really need to write a USB daemon to allow the "Brightness" button to
>work on the DFP monitors from Apple.

There are at least 2 nice daemons beeing worked on that currently
only handle recent laptop keys but those will be improved over time.
We also need a better API that what the kernel currently provides for
the brightness, especially when dealing with X as it is not safe to
let the kernel tap the card registers the way it does currently while
X is doing the same below.

>The only way I could seem to reduce the brightness was to use the Gamma
>0.50 setting in the XF86Config-4 file to reduce the gamma
>
>Ani/Ben I will try to send you whatever patches are needed for radeonfb.c
>for the 7500 (once I clean up my hacks) so that you can see what I had to
>do.
>
>Now on to SMP kernel testing!

I'm still working on proper L3 support, I'll push when it's ready.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
