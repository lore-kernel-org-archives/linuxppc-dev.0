Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 6CE89DDF16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 06:15:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Thu, 17 Jul 2008 13:15:19 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702B647D0@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.2280.1216290829.2883.linuxppc-embedded@ozlabs.org>
References: <mailman.2280.1216290829.2883.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah,

May be I am missing some thing. I am sure you looked at the obvious.

Is there any reason why you are not using blocked read in application
pthread (a separate thread if necessary), so that driver provides that
value back to the application. Isn't that the right way to implement?

- Siva

Misbah khan <misbah_khan@engineer.com> wrote:

In have a sdram of size 9MB which i would map to kernel space (ioremap
would
do that ) the whole 9 MB kernel virtual memory i need to map to the
application , the application would read when driver has complited
writing
and vice versa this implimentation would be in a circular buffer type.
The
size of my RAM is 128 MB=20
