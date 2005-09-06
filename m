Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DF7D68116
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2005 12:27:37 +1000 (EST)
Date: Tue, 6 Sep 2005 03:27:33 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Message-ID: <20050906022733.GU5155@ZenIV.linux.org.uk>
References: <20050906004423.GO5155@ZenIV.linux.org.uk>
	<20050906021535.GA5512@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050906021535.GA5512@gate.ebshome.net>
Sender: <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 05, 2005 at 07:15:35PM -0700, Eugene Surovegin wrote:
 
> Identical fix is already in -mm

Then it really should go upstream; obvious fixes like that are not
something that needs filtration...
