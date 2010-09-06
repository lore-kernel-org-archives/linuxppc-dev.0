Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 629AEB70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 00:15:33 +1000 (EST)
Received: by iwn4 with SMTP id 4so4318350iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 06 Sep 2010 07:15:31 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 6 Sep 2010 10:15:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH] APM821xx: Add support for new SoC APM821xx
Message-ID: <20100906141513.GA15942@hansolo.jdub.homelinux.org>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
	<20100905222340.GC2150@lixom.net>
	<01bb9090932e6984c887273078fd586f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01bb9090932e6984c887273078fd586f@mail.gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 05, 2010 at 10:19:53PM -0700, Tirumala Marri wrote:
>>
>> Then the device tree identifier, and the cpu setup functions, etc,
>> should indicate
>> 464, not APM821xx.
>This is new SoC based on 464 cpu core. All the previous SoC device tree
>CPU portion uses SoC name.
>
>>
>> Also, why add yet another defconfig? Isn't the eval board similar to
>> many others and can be supported with just a tweak of some existing
>> common defconfig instead?
>>
>Every new board needs new defconfig. And it is not same as others. It has
>Different features from other.

You make it sound as if that is a hard and fixed rule.  It's not.  Not all
boards need a defconfig.  Also, there was recent work to trim the defconfigs
that exist today down so they are not so large.  I suggest you do the same
if you want the defconfig included.

josh
