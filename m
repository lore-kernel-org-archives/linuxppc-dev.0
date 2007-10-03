Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D4407DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 12:07:01 +1000 (EST)
Date: Tue, 2 Oct 2007 21:11:05 -0500
From: Olof Johansson <olof@lixom.net>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] Use 1TB segments
Message-ID: <20071003021105.GA6553@lixom.net>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1191350274.18159.279.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1191350274.18159.279.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Oct 02, 2007 at 01:37:54PM -0500, Will Schmidt wrote:
> [RFC v2] 1TB Segment size support
> 
> From:  <>
> 
> 1TB Segment size support
> 
> This makes the kernel use 1TB segments for all kernel mappings and for
> user addresses of 1TB and above, on machines which support them
> (currently POWER5+ and POWER6).

PA6T supports them as well :)

>                                 We don't currently use 1TB segments
> for user addresses < 1T, since that would effectively prevent 32-bit
> processes from using huge pages unless we also had a way to revert to
> using 256MB segments.

Wouldn't it be possible to stick with 1TB segments for the low range
for 64-bit processes as well, and have them allocate their hugepages
at >1TB?


-Olof
