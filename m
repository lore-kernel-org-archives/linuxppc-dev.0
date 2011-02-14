Return-Path: <ohad@bencohen.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94525B710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 21:04:22 +1100 (EST)
Received: by pvg13 with SMTP id 13so1031470pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 02:04:19 -0800 (PST)
MIME-Version: 1.0
Sender: ohad@bencohen.org
In-Reply-To: <20110214100104.GC4371@pulham.picochip.com>
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
From: Ohad Ben-Cohen <ohad@wizery.com>
Date: Mon, 14 Feb 2011 12:03:59 +0200
Message-ID: <AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
To: Jamie Iles <jamie@jamieiles.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Meador Inge <meador_inge@mentor.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 12:01 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>> =A0 =A0 1. Hardware specific bits somewhere under '.../arch/*'. =A0Drive=
rs
>> =A0 =A0 =A0 =A0for the MPIC message registers on Power and OMAP4 mailbox=
es, for
>> =A0 =A0 =A0 =A0example.
>> =A0 =A0 2. A higher level driver under '.../drivers/mailbox/*'. =A0That =
the
>> =A0 =A0 =A0 =A0pieces in (1) would register with. =A0This piece would ex=
pose the
>> =A0 =A0 =A0 =A0main kernel API.
>> =A0 =A0 3. Userspace interfaces for accessing the mailboxes. =A0A
>> =A0 =A0 =A0 =A0'/dev/mailbox1', '/dev/mailbox2', etc... mapping, for exa=
mple.
>
> How about using virtio for all of this and having the mailbox as a
> notification/message passing driver for the virtio backend?

This is exactly what we are doing now, and it looks promising. expect
patches soon.
