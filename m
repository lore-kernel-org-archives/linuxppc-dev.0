Message-ID: <38F101BF.1BDD5BD1@wibble.net>
Date: Mon, 10 Apr 2000 08:18:39 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Remaining Pismo issues
References: <38F0DD9A.E5DA1AEB@dana.ucc.nau.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -  Power management in Linux is not so good.  In comparison with the
> MacOS (bad comparison, I know), the battery on my Pismo seems to last
> about an hour less.

currently power management is still not supported. This is correct. The
power management works with the older PMU on Lombard and such (paulus'
notebook I believe is a lombard and I have seen the power managemant
working on it) People thought it would be better to get linux booting
and running on the Pismo before they attempted to get power management
working. This is obviously the order to do things in, after all, isnt it
better to have power management but not be able to boot into the OS <g>
(sorry for bad joke attempts)

Anyway now that things are working I suspect people will work more on
power management. Read through the list archives if you want to see
further details of all this. This is where I read all the stuff I can
find so far about the new PMU (I only own one ppc machine, a lowly
7220/200)

> If I understand correctly, Apple used a new kind of
> PMU in the new laptops.  Is this correct, and if so, how well is the new
> chip supported?

it isnt, if you read through the archives you will see there is as yet
no full support for the new chip in linux. People have done minimal
things to get through booting and such, but there is no power management
support yet.

> - Somewhat related to power management problem, the laptop gets much
> hotter when using Linux.  The internal fan runs almost constantly.
> Plus, the computer will often hit the shutdown point of the
> motherboard.  This causes the operating system to freeze, because the
> computer can't operate at such high temperatures.  Has anyone seen this
> problem before and found a way around it?

yes almost definitely power management related as I mention above.

> - I had tried to run KDE on my machine using the kdm login manager.  For
> some reason, this would not work correctly, and X kept returning the
> error "stdin: is not a tty".  I switched back over to the gdm login
> manager, and everything seems to work ok.

no idea, however if this other method works, use it, after all the
display manager should ot be a big issue in usability.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
