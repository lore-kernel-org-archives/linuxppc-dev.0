Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8DA2BB716B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 00:23:18 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id D2297DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 00:23:16 +1000 (EST)
Received: by gxk6 with SMTP id 6so1739418gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 07:23:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090414215342.GB9877@ovro.caltech.edu>
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
	<20090414215342.GB9877@ovro.caltech.edu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 08:22:54 -0600
Message-ID: <fa686aa40906110722y1b4b8c22l7ccdd32d6684324d@mail.gmail.com>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 14, 2009 at 3:53 PM, Ira Snyder<iws@ovro.caltech.edu> wrote:
> On Tue, Apr 14, 2009 at 02:28:26PM -0600, Grant Likely wrote:
>> On Mon, Feb 23, 2009 at 6:00 PM, Ira Snyder <iws@ovro.caltech.edu> wrote=
:
>> > This adds support to Linux for using virtio between two computers link=
ed by
>> > a PCI interface. This allows the use of virtio_net to create a familia=
r,
>> > fast interface for communication. It should be possible to use other v=
irtio
>> > devices in the future, but this has not been tested.
>>
>> Hey Ira,
>>
>> I like this a lot. =A0I need to do much the same thing on one of my
>> platforms, so I'm going to use your patch as my starting point. =A0Have
>> you made many changes since you posted this version of your patch?
>> I'd like to collaborate on the development and help to get it
>> mainlined.
>>
>
> This would be great. I'd really appreciate the help. I haven't had time
> to make any changes since I last posted the patch. I started work on
> converting all of the usage of struct vop_loc_* to just use the on-wire
> structures, but I didn't get very far before other work got in the way.
>
>> In my case I've got an MPC5200 as the 'host' and a Xilinx Virtex
>> (ppc440) as the 'client'. =A0I intend set aside a region of the Xilinx
>> Virtex's memory space for the shared queues. =A0I'm starting work on it
>> now, and I'll provide you with feedback and/or patches as I make
>> progress.
>>
>
> I'm looking forward to seeing your implementation. If you have any
> questions, I'd be happy to attempt to answer them :)

Hey Ira,

I've been slowly hacking on your virtio-over-pci stuff.  I've got an
initial series of cleanup patches which address some of the comments
from this thread.  Before I send them to you, have you made any
changes on your end?  They likely won't apply without changes to the
core code, so I'd like to sync up with you first.

Cheers,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
