Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Olaf Hering <olh@suse.de>,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: new G4 dual 1 gig is here - how to install?
Date: Wed, 13 Feb 2002 08:49:40 -0500
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
References: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca> <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca> <20020213090002.B4386@suse.de>
In-Reply-To: <20020213090002.B4386@suse.de>
MIME-Version: 1.0
Message-Id: <20020213134454.HEFJ3415.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thanks everyone for you helpful hints.

I have now done a make zImage and built  it so I will try that option
tonight.

I was also able to boot into Mac OS 9.2 and run DisplayNameRegistry and
dumped it to a file so I should be able to figure out the correct path to
the scsi boot device from that info (I hope).

If not, I will try the idea of putting a small Mac OS boot script on a
scsi partion and try to use the "print-env" boot-device info to figure out
the of boot path.  And then I will try either changing the ofboot.b script
or trying to boot yaboot directly.

I will give all of these things a try tonight and report back.

Thanks again for all of the ideas.

Kevin

On February 13, 2002 03:00, Olaf Hering wrote:
> On Tue, Feb 12, Kevin B. Hendricks wrote:
> > BTW: Are there any nice utilities to let me snoop through the OF
> > device tree under Mac OSX.  I know I can get DisplayName Registry to
> > work under MacOS 9.2 but would rather do my machine snooping under OSX
> > if possible.
>
> Copy the boot file in the root of a hfs partition, select that one as
> boot volume. Boot to OF prompt, type "printenv boot-device", that will
> give you a clue about that path name. Then change the ,\\:tbxi part to
> ,filename.
>
>
> Gruss Olaf

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
