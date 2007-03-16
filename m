Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (unknown [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F24C3DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 11:05:33 +1100 (EST)
Date: Thu, 15 Mar 2007 19:18:43 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: arch/powerpc Kconfig cleanup
Message-ID: <20070316001843.GA7220@lixom.net>
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 06:34:25PM -0500, Kumar Gala wrote:
> I didn't know if people were ok with having these move under the 'Platform
> support' menu or would prefer they stay as top level menu choices.  Here's
> a work up of a patch for Cell that moves things around and puts the 'Cell
> Broarband Engine options' under 'Platform support'.

Looks good to me. I rarely notice menu organization myself since I tend
to edit .config by hand and run menuconfig. Go for it.


-Olof
