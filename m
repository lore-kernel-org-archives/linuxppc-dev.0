Message-ID: <40DB2199.2050006@mvista.com>
Date: Thu, 24 Jun 2004 11:46:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>	 <40DA06BE.204@mvista.com> <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
In-Reply-To: <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>You are lost in a twisty maze of BK trees, all alike.
>
>On Wed, 2004-06-23 at 15:39 -0700, Mark A. Greer wrote:
>
>
>>You should sync up with Brian Waite (look at CC: list) who has been
>>looking at writing a new enet driver for the 2.6 kernel using the latest
>>bridge support code.  You can get a look at the latest support code by
>>cloning bk://source.mvista.com/linux-2.5-marvell.  Note the the mpsc
>>driver that's there still isn't working correctly.
>>
>>
>
>Ooh look another one. What's in here that merits it having its own tree
>and prevents it from being accepted upstream?
>
It doesn't "merit" its own tree; it has its own tree because the code is
not yet ready to be passed upstream but others need to see the code.  If
you don't want to deal with the code in this tree, don't.  When it is
ready, and eventually [hopefully] accepted into the kernel.org tree,
this tree will disappear.

>
>Please be as specific as you can -- my task for the next few weeks
>involves making Dy-4 DMV-182 support happen.
>

This tree has a complete rewrite of the core code.  Look at
arch/ppc/syslib/.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
