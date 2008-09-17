Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18641.20490.57726.608342@cargo.ozlabs.ibm.com>
Date: Wed, 17 Sep 2008 11:44:26 -0700
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: build failure with current linus tree
In-Reply-To: <48D146C4.4010108@nortel.com>
References: <20080905010618.GA30278@lst.de> <20080909235626.GA5254@lst.de>
	<48D146C4.4010108@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> Is there a proper fix other than simply reverting that commit?

It appears that we have a choice between having CONFIG_FTRACE work
with gcc 4 and not gcc 3 (the current situation), and having
CONFIG_FTRACE work with gcc 3 and not gcc 4 (which is what we would
have if that commit was reverted).

I think more people use gcc 4 than gcc 3 these days, which is why I
haven't reverted that commit.

Paul.
