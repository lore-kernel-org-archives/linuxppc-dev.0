Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18694.33145.358557.610157@cargo.ozlabs.ibm.com>
Date: Tue, 28 Oct 2008 14:05:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Work around ld bug in older binutils
In-Reply-To: <20081027205838.5f1fcbff@lappy.seanm.ca>
References: <18688.257.812926.680480@drongo.ozlabs.ibm.com>
	<20081027205838.5f1fcbff@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan writes:

> I'd like to try this. I did a git revert to back out the aforementioned
> commit. How do I get it back? Do I git revert again?

You could revert the reversion, or else rebase any patches you have on
top of the reversion onto the commit before the reversion.

Paul.
