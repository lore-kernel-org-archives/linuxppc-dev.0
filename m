From: "Calum Selkirk" <cselkirk@xs4all.nl>
Date: Thu, 17 Jul 2003 12:11:49 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: firewire in 2.4.21-ben2
Message-ID: <20030717101149.GA2393@xs4all.nl>
Reply-To: Calum Selkirk <cselkirk@xs4all.nl>
References: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com> <1058261452.628.36.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1058261452.628.36.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Benjamin Herrenschmidt [benh@kernel.crashing.org] [2003-07-15 11:30 +0200]:

[snip]
> >   After I reboot back in 2.4.20-ben10 everything works fine...
>
> That's a change in the firewire layer, you have to trigger a scsi
> probe yourself now. Either using the rescan-scsi-bus.sh script, or the
> scsiadd command for example

just FYI, I have had the kernel oops on one occasion when rescaning the
scsi bus this way (with a 2.4.21-ben2). Sorry, wasn't able to get a
backtrace, though I will attempt to if it happens again.

best regards

cal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
