Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FE6CB6F1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 00:07:07 +1100 (EST)
Date: Wed, 25 Nov 2009 05:01:31 -0800
From: Greg KH <gregkh@suse.de>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH v2 2/3] sysfs cpu probe/release files
Message-ID: <20091125130131.GA18248@suse.de>
References: <4B0CD70F.6090600@austin.ibm.com> <4B0CD8D5.8050803@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B0CD8D5.8050803@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 01:12:21AM -0600, Nathan Fontenot wrote:
> In order to support kernel DLPAR of CPU resources we need to provide an
> interface to add (probe) and remove (release) the resource from the system.
> This patch Creates new generic probe and release sysfs files to facilitate
> cpu probe/release.  The probe/release interface provides for allowing each
> arch to supply their own routines for implementing the backend of adding
> and removing cpus to/from the system.
>
> This also creates the powerpc specific stubs to handle the arch callouts 
> from writes to the sysfs files.

Can you document these new sysfs files with some information in the
Documentation/ABI/ directory please?

thanks,

greg k-h
