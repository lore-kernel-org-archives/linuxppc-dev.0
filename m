Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF2E0DDF3A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 01:34:54 +1100 (EST)
Message-Id: <12F84CB4-8344-4F70-A89F-4A1FF590C35C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18371.65529.312001.673609@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to master & powerpc-next branches of powerpc.git
Date: Tue, 26 Feb 2008 08:34:49 -0600
References: <18371.65529.312001.673609@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 26, 2008, at 6:03 AM, Paul Mackerras wrote:

> I have created a powerpc-next branch in the powerpc.git tree, which
> has the following commits on it so far.  The master branch is at the
> same point.  I've pulled in Dave Miller's tree (for the LMB changes)
> and applied some other patches from the list.
>
> I'm expecting that platform/subarchitecture maintainers will be
> sending me pull requests for their trees from time to time.
>
> Paul.

How do you plan on managing the powerpc-next branch in the future?   
For example, I assume at some point linus will pull it into what would  
be 2.6.26.  Would you rebase this branch?  etc.

- k
