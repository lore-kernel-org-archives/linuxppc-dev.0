Return-Path: <wrobell@pld-linux.org>
Received: from dk.wroc.pl (amw.wroc.pl [62.233.177.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Test Certificate", Issuer "Test Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7ECF2BDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2004 21:32:03 +1100 (EST)
Date: Fri, 26 Nov 2004 11:29:15 +0100
From: wrobell <wrobell@pld-linux.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041126102915.GA30059@pred>
References: <41A62853.8060107@emse.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41A62853.8060107@emse.fr>
Subject: Re: pb booting 2.6.9 kernel on Tibook
Reply-To: wrobell <wrobell@pld-linux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 25, 2004 at 07:45:39PM +0100, Philippe Jaillon wrote:
> Hi,
> 
> I have problem configuring a booting 2.6 kernel. it hang at
> "adb: starting probe task"
I've had similar problem, but after applying Ben's ibook sleep patch it has
gone.

[...]

    wrobell <wrobell@pld-linux.org>
