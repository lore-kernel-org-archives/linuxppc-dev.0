Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id E4C14DE084
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:05:27 +1100 (EST)
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH 5/16] Ops based MSI implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083411.5D935DE2FD@ozlabs.org>
	<20070125215209.GA3126@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 25 Jan 2007 14:05:11 -0800
In-Reply-To: <20070125215209.GA3126@kroah.com> (Greg KH's message of "Thu,
	25 Jan 2007 13:52:09 -0800")
Message-ID: <adahcueoj8o.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Are you sure of the "any later version" part?

The command

    git grep "at your option) any later version"

finds more than 3000 matching files in my kernel source tree, so I
think existing practice shows it's fine if someone wants to license
a file for kernel inclusion that way.

 - R.
