Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6CE0@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Frank Przybylski '" <fp@vas-gmbh.de>,
	Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: insmod / add-symbol-file
Date: Fri, 7 Dec 2001 13:05:54 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I use -O, I still have the same problems.

Without optimization, insmod complains that in_8 and out_8 are unresolved. I
removed the code that needs this, so that it could load. But unfortunately,
the same problem. :-<<

Thanks,
Fred

-----Original Message-----
From: Frank Przybylski
To: Goddeeris Frederic; linuxppc-embedded@lists.linuxppc.org
Sent: 12/7/01 12:24 PM
Subject: Re: insmod / add-symbol-file

Hi Goddeeris,

> I use the gcc and gdb from the MontaVista CDK 2.0 for
> PPC_8xx. I compiled
> the module with "-O2 -g" options.

Have you tried to compile with "-O -g" options instead of "-O2 -g"?
I'd guess optimization 'confuses' gdb symbols. Maybe have a try even
without -O,
 as I only know for sure that the kernel needs an optimization step to
get some things
properly setup.

hth
 Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
