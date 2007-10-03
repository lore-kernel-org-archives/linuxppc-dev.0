Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 61113DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:33:14 +1000 (EST)
Date: Wed, 3 Oct 2007 18:34:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to the
	QE library
Message-ID: <20071003143417.GA5123@localhost.localdomain>
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
	<4703A453.8080305@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4703A453.8080305@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 09:16:51AM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>> Hi Timur,
>> On Thu, Sep 20, 2007 at 03:47:26PM -0500, Timur Tabi wrote:
>>> This patch makes numerous miscellaneous code improvements to the QE 
>>> library.
>> ...and also breaks MPC8568E-MDS. ;-) Board hangs just after ip-config 
>> stuff.
>> Commit 589ffa1c520355e37d5868 in galak/powerpc.git.
>> Unfortunately it isn't split, thus it will take time to track faulty bit.
>> But so far... maybe you have any ideas?
>
> No.  The changes are supposed to be completely transparent.  I did have to 
> modify the ucc_geth driver because of a change in some QE library 
> functions, but I tested it on 8360 and it works there.

I see.

> It could be something peripheral, like a general breakdown of the QE itself 
> on 85xx.

Doubtfully, if changes are completely transparent. Because everything works
here without that cleanup.

Ok, thanks anyway, will look further as time will permit.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
