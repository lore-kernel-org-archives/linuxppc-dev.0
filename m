Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17929.44382.889989.174949@cargo.ozlabs.ibm.com>
Date: Wed, 28 Mar 2007 09:48:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
In-Reply-To: <1175026241.1398.23.camel@goblue>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
	<1175026241.1398.23.camel@goblue>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> I just had to realign the start_index in case it didn't start at a 4GB
> boundary.  Other than that, it worked like a champ.  I also changed to
> for loop to exit if it's the last entry.

If this is now suitable for going upstream, please re-send with a
proper patch description, e.g. the original patch description modified
or augmented as necessary for the changes you've made.  A description
of what has changed since the previous version of the patch is not
suitable as the commit text in the git repository.

Paul.
