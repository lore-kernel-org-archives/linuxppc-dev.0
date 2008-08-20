Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id AD06CDE175
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:15:22 +1000 (EST)
Received: by gxk14 with SMTP id 14so199985gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:15:20 -0700 (PDT)
Message-ID: <fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
Date: Wed, 20 Aug 2008 08:15:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
In-Reply-To: <200808201533.22258.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2008 at 7:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 August 2008, Josh Boyer wrote:
>> This adds a common board file for almost all of the "simple" PowerPC 44x
>> boards that exist today.  This is intended to be a single place to add
>> support for boards that do not differ in platform support from most of the
>> evaluation boards that are used as reference platforms.  Boards that have
>> specific requirements or custom hardware setup should still have their own
>> board.c file.
>
> The code looks correct, but since this is going to be example code
> that may get copied into other platforms, I would take extra care
> for coding style:

I second Arnd's comments.  Otherwise, this looks pretty good to me.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
