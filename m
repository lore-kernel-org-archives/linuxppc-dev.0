Date: Wed, 13 Feb 2002 06:37:36 +0100
From: Olaf Hering <olh@suse.de>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: new G4 dual 1 gig is here - how to install?
Message-ID: <20020213063736.A25319@suse.de>
References: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 12, Kevin B. Hendricks wrote:

> So what is the best way to get linux working on this thing.  Since
> kernel changes are needed to recognize the new 7455 chip, none of the
> canned installers from SuSE, or YellowDog will work, will they?

Boot a arch/ppc/boot/images/vmlinux.initrd.elf-pmac. A ramdisk.image.gz
can be found on CD1/suse/images/



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
