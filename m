Return-Path: <jwboyer@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id B27DA474C1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 08:01:31 +1100 (EST)
Received: by ewy14 with SMTP id 14so7391993ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Feb 2009 13:01:29 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 9 Feb 2009 16:01:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] edac: new ppc4xx driver module
Message-ID: <20090209210119.GF2297@yoda.jdub.homelinux.org>
References: <20090130140520.ca1b2b8e.akpm@linux-foundation.org>
	<C5B1D239.14743%gerickson@nuovations.com>
	<20090206114947.ea86ee58.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090206114947.ea86ee58.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Grant Erickson <gerickson@nuovations.com>,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 06, 2009 at 11:49:47AM -0800, Andrew Morton wrote:
>On Fri, 06 Feb 2009 11:40:41 -0800
>Grant Erickson <gerickson@nuovations.com> wrote:
>
>> On 1/30/09 2:05 PM, Andrew Morton wrote:
>> > On Fri, 30 Jan 2009 09:54:42 -0700 dougthompson@xmission.com wrote:
>> >> From: Grant Erickson <gerickson@nuovations.com>
>> > 
>> > Perhaps a powerpc mailing list should have been cc'ed?
>> 
>> The first round patch went to Doug, the BlueSmoke (EDAC) mailing list and
>> the Linux/PowerPC mailing list. However, because the original patch was
>> split in two, subsequent revisions of just the EDAC piece went to Doug and
>> BlueSmoke. Doug then forwarded it to linux-kernel.
>> 
>> What's the preferred sign-off, ACK chain for this subsystem? Through
>> PowerPC/4xx or PowerPC GIT upstream or through you and -mm upstream?
>
>I don't trust those guys ;)

I might take offense to that, but it seems that there aren't too many people
in general that you trust, so I guess that's fine. ;)

(And while you may or may not be joking, if there's something that I've done
to be considered not trustworthy then please let me know.)

>I'd merge it via -mm, while cc'ing various random powerpc personalities.

Erm, ok.  Since there doesn't appear to be an EDAC git tree for -next I
guess that makes sense.  I'll try to review the most recent version in the
next few days.

josh
