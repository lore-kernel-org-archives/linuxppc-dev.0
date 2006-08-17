Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 7527667B69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 11:40:32 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so368310ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 18:40:31 -0700 (PDT)
Message-ID: <528646bc0608161840u62d217cbv7eab091975920c4b@mail.gmail.com>
Date: Wed, 16 Aug 2006 19:40:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Jeff Angielski" <jangiels@speakeasy.net>
Subject: Re: Linux hanging on Xilinx SystemACE
In-Reply-To: <1155775917.10357.37.camel@sumo-jaa>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
	<528646bc0608161448y26e13398v3b818ed5f1124295@mail.gmail.com>
	<1155775917.10357.37.camel@sumo-jaa>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/16/06, Jeff Angielski <jangiels@speakeasy.net> wrote:
> On Wed, 2006-08-16 at 15:48 -0600, Grant Likely wrote:
> > Checking partitions is a user-space activity (fsck).  Remove it from
> > your init scripts.  Besides, unless your using a microdrive, your ext2
> > rootfs should be mounted read-only which greatly reduces the need for
> > fsck.  (because FLASH will wear out after too many writes)
>
> The partition check he is referring to is part of a block device driver
> initialization.  It is not fsck.  If he were only so luck to be that far
> in the startup sequence... :)

heh; I grepped the 2.6 kernel tree for "Partition check" and didn't
find anything, and I assumed that it wasn't in 2.4 either.  Therefore
it must be a fsck message...

You know what they say about assuming.

oops

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
