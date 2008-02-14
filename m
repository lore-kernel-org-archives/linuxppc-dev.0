Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4841DDFB0
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 09:13:51 +1100 (EST)
Date: Thu, 14 Feb 2008 14:45:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: David Miller <davem@davemloft.net>
Subject: Re: /proc/bus/pci and domains
Message-ID: <20080214214506.GB7657@parisc-linux.org>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
	<mj+md-20080214.093558.3352.nikam@ucw.cz>
	<20080214.134305.237408044.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214.134305.237408044.davem@davemloft.net>
Cc: greg@kroah.com, mj@ucw.cz, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2008 at 01:43:05PM -0800, David Miller wrote:
> From: Martin Mares <mj@ucw.cz>
> Date: Thu, 14 Feb 2008 10:40:22 +0100
> 
> > Would it be acceptable for the PPC folks to modify the code to add
> > domain numbers to the device numbers in /proc/bus/pci/devices in the
> > same format as the bus directories already have?
> 
> Be careful, things like the X server parse that file, and X's
> parser does not expect domain numbers there so you will break
> things :-(

It might be best if we only place domain 0 in that file.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
