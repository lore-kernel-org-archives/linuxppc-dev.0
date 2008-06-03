Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B021DE393
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 21:59:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m53Bx6cI009562
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 07:59:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m53Bx5K1115906
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 05:59:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m53Bx5xT026522
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 05:59:05 -0600
Date: Tue, 3 Jun 2008 06:52:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
Subject: Re: [RFC] Kprobes for book-e
Message-ID: <20080603065212.35f7f054@zod.rchland.ibm.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D260869@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D260869@insardxms01.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "Sulibhavi,
	Madhvesh" <madhvesh.s@ap.sony.com>, rsmadhvesh@vsnl.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jun 2008 13:53:37 +0530
"Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com> wrote:
 
> Kumar, i would like to test the updated kprobes patches on my
> ebony target using latest kernel. But i am facing build issues using
> 2.6.26.rc3 for powerpc arch while using the ebony configuration.
> I tried it using paulus git tree, but could not succeed. If you have
> any ideas on any stable version of latest tree where ebony config
> can be built using powerpc arch, please let me know.

What build issues?  Ebony should build fine for 2.6.26-rc3, unless
you're trying to apply this patchset to it without the other patches it
requires.

You'll need to use either my git tree with Kumar's exception series
applied, or use Kumar's tree.  The kprobes code is 2.6.27 material,
so .26-rc3 (or -rc4) is too old.

josh
