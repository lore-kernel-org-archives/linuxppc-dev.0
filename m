Message-Id: <v04003a04b8e03cacee74@[24.70.162.28]>
In-Reply-To: <20020415074341.4272.qmail@web11003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 15 Apr 2002 03:26:36 -0500
To: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: 9600 maturity?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:43 AM -0500 4/15/02, Dan Bethe wrote:
>Hi all.  I am considering getting a Powermac 9600 with a single 200 MHz
>604e to
>replace my 8500 as a production server.  I can't find any info so far on the
>maturity of Linux's support of the 9600.  I read that a while back there were
>SMP problems, video problems, and problems with some types of PCI cards in the
>2nd PCI bus (the lower three slots).  The PCI problem was also had on MacOS at
>some point in time, so I wonder if they worked around it with something like a
>System Enabler and I wonder if such knowledge is incorporated into Linux.
>
>Can anyone confirm whether Linux support of the 9600 is at least as rock solid
>as that of the 8500?  I need it to be all around ideal or else it's not good
>enough.  Or give ideas on where to search for it other than the mailing lists
>at lists.linuxppc.org and lists.yellowdoglinux.com?  Google shows nothing so
>far.
>
>Thanks to all who contribute to that hardware family.... well, and to anything
>else too  :}

I've not had too much trouble with my 9600/200mp. I haven't used it much
since early 2.4, mind you (got enough other unix boxes on my desktop), but
it worked pretty well at the time. The only rub with the SMP was that if
MacOS 9 got ahold of the second CPU, linux would fail to grab it when it
booted. I solved it by booting from an 8.1 boot floppy, but that obviously
won't be a problem for you.

I haven't had much trouble with the PCI. I'm running a Promise Ultra66 and
a 21143 ethernet card in the top slots, and the standard IMSTT video in the
bottom. (though I'm looking to replace that with a Radeon7000 PCI - IMSTT
is kinda slow by modern standards)


I'd definatley pick a 9600 to run linux on over an 8500 - if for no other
reason than it having the very cool flip&fold case. 8)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
