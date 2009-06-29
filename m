Return-Path: <iant@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2710DB708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 07:39:00 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BB08DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 07:38:58 +1000 (EST)
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com
	[172.28.16.141]) by smtp-out.google.com with ESMTP id n5TLRsIX019187
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 22:27:54 +0100
Received: from pzk16 (pzk16.prod.google.com [10.243.19.144])
	by spaceape7.eur.corp.google.com with ESMTP id n5TLRokP032031
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:27:51 -0700
Received: by pzk16 with SMTP id 16so420727pzk.0
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:27:50 -0700 (PDT)
To: David Howells <dhowells@redhat.com>
Subject: Re: Inline Assembly queries
References: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<30098.1246291036@redhat.com>
From: Ian Lance Taylor <iant@google.com>
Date: Mon, 29 Jun 2009 14:27:48 -0700
In-Reply-To: <30098.1246291036@redhat.com> (David Howells's message of "Mon\,
	29 Jun 2009 16\:57\:16 +0100")
Message-ID: <m3prcm20iz.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org,
	kernel mailz <kernelmailz@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Howells <dhowells@redhat.com> writes:

> kernel mailz <kernelmailz@googlemail.com> wrote:
>
>> asm("sync");
>
> Isn't gcc free to discard this as it has no dependencies, no indicated side
> effects, and isn't required to be kept?  I think this should probably be:
>
> 	asm volatile("sync");

An asm with no outputs is considered to be volatile.

Ian
