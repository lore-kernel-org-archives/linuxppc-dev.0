Message-ID: <40B58C98.40205@fh-landshut.de>
Date: Thu, 27 May 2004 08:37:12 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioremap() question
References: <40B4AB27.5020202@fh-landshut.de> <20040526171234.GA4255@gate.ebshome.net>
In-Reply-To: <20040526171234.GA4255@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

>On Wed, May 26, 2004 at 04:35:19PM +0200, Oliver Korpilla wrote:
>
>
>You cannot use virt_to_bus() on ioremap returned addresses.
>
>
>
Thanks! Do I need something like phys_to_bus() instead?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
