Date: Thu, 13 Mar 2003 09:52:24 +0100
From: Olaf Hering <olh@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Debugging
Message-ID: <20030313095224.A24516@suse.de>
References: <20030311202811.A13099@suse.de> <XFMail.20030313092851.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20030313092851.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Mar 13, Giuliano Pochini wrote:

>
> On 11-Mar-2003 Olaf Hering wrote:
> >
> >  On Tue, Mar 11, Giuliano Pochini wrote:
> >
> >> I'm using 2.4.21p4 on a blue G3. I recompiled Kernel, modules, ALSA
> >> to be sure System.map is the right one.
> >
> > Get an ADB keyboard and use that for xmon.
>
> :( I sold it a few months ago. Can macs without ADB run xmon ?

Via Firewire maybe, but your onboard pcilynx controller ist not supported.

--
A: No.
Q: Should I include quotations after my reply?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
