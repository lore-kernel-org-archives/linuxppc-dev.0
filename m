Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B56C1DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 00:54:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m53Es9ob005146
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 10:54:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m53Es1AS090044
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 08:54:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m53ErsBJ022920
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 08:53:57 -0600
Date: Tue, 3 Jun 2008 09:46:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
Subject: Re: [RFC] Kprobes for book-e
Message-ID: <20080603094659.6fb303fd@zod.rchland.ibm.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D2609F3@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D2609F3@insardxms01.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jun 2008 20:18:01 +0530
"Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com> wrote:

> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org] 
> > Sent: Tuesday, June 03, 2008 8:08 PM
> > To: Josh Boyer
> > Cc: Sulibhavi, Madhvesh; linuxppc-dev@ozlabs.org; 
> > rsmadhvesh@vsnl.net; Paul Mackerras
> > Subject: Re: [RFC] Kprobes for book-e
> > 
> 
> > This looks like the binutils problem that cell was having and I  
> > believe Alan Modra fixed:
> > 
> > http://sourceware.org/ml/binutils/2008-05/msg00008.html
> > 
> Thanks, is it posible to get latest binutils binary which
> is applied with this fix? If i just upgrade binutils, will
> it solve this problem or i have to rebuild gcc etc etc..

A newer binutils should work just fine.  Also, and older one would
likely work too.  I use either 2.15 or 2.18.

josh

P.S.  You should really get rid of that disclaimer message at the
bottom of your emails.  You're sending to a public list so it makes no
sense.
