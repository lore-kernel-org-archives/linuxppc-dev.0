From: "Geiser, Ian" <geiseri@msoe.edu>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: mnorton@cisco.com, linuxppc-dev@lists.linuxppc.org
Date: Fri, 15 Sep 2000 08:17:50 -0500 (CDT)
Subject: Re: Speech Recogniton
In-Reply-To: <v04220801b5e7574c37ed@[10.0.0.42]>
Message-ID: <Pine.LNX.4.10.10009150815360.754-100000@sleepchamber.geekcentral.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Sep 2000, Timothy A. Seufert wrote:

>
> At 4:57 AM -0400 9/14/00, Michael Norton wrote:
> >hi,
> >
> >Do any libraries exist that allow me to use the Apple Speech recognition
> >hardware under LinuxPPC?
>
> Sorry, there is no hardware (aside from a simple digitizer to capture
> the sound of course).  Apple's speech recognition is 100% software.
>
> The original implementation on 68K Macs used an AT&T DSP coprocessor
> to do the crunching because the 68K didn't have enough oomph to do it
> by itself, but the PowerPC implementation relies on nothing but the
> CPU.
>
	on the off chance that you can get sound input
	to work under LinuxPPC (i have a pimiso pb so it cant AFAIK)
	try checking on freshmeat.  There are a few programs
	that can do voice control.  One of them is called voicecontrol
	i think.

	I have only played with festival which can to Text to speech.

	-ian reinhart geiser

.---------------------------------------------------.
| Ian Reinhart Geiser - Computer Engineering Student|
| HOME: <geiseri@msoe.edu>                          |
| WORK: <geiseri@linuxppc.com>                      |
| WEB:  http://www.msoe.edu/~geiseri                |
`---------------------------------------------------'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
