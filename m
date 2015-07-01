Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D26A21A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 17:32:48 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A6021402AB
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2015 17:32:47 +1000 (AEST)
Date: Wed, 1 Jul 2015 02:32:38 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, thuth@redhat.com, aik@ozlabs.ru, dvaleev@suse.com
Subject: Re: [PATCH SLOF v3 3/5] disk-label: rename confusing "block" word
Message-ID: <20150701073238.GA8068@gate.crashing.org>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435662081-4293-4-git-send-email-nikunj@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435662081-4293-4-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 30, 2015 at 04:31:19PM +0530, Nikunj A Dadhania wrote:
> "block" word is not a block number, actually its an allocated host
> address.  Rename it to disk-buf along with a associated
> size(disk-buf-size=4096) for using during allocation/free.
> 
> Also renaming the helper routine read-sector to read-disk-buf. This
> routine assumes the address to be disk-buf and only takes sector number
> as argument.

This isn't what I suggested, and I think it is a terrible idea.
Just FWIW :-)


Segher
