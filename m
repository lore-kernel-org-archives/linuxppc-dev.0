Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 5842A67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 02:16:08 +1100 (EST)
Date: Thu, 17 Mar 2005 10:14:41 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Patrick Huesmann <patrick.huesmann@gmail.com>
In-Reply-To: <93579fec05031706597355371c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503171011220.20335@localhost.localdomain>
References: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
	<93579fec05031706597355371c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: looking for a model for building CRAMFS(?)-based system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 17 Mar 2005, Patrick Huesmann wrote:

> I'm using separate MTD partitions for bootloader, device parameters,
> zImage, initrd and persistent storage.
>
> When updating the initrd, the only thing necessary is a
> eraseall /dev/mtdX
> cat initrd.gz > /dev/mtdX

now this is the sticky part.  imagine this system out in the field,
where you need to make an update to something in the initrd in the
root filesystem.

one technique would be to, of couse, download an entirely new
initrd.gz and reflash (hoping no one pulls the plug as you're doing
it), as you describe above.

what about sacrificing space and having an uncompressed root
filesystem in flash?  and, if that's possible, would one mount it
read-only from flash (speed?), or just copy it into RAM and mount that
every time?

if all this is covered somewhere, a URL would be fine, thanks.

rday
