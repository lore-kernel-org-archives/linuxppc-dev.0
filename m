Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id CE33E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 21:04:31 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so219152wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Mar 2005 02:04:30 -0800 (PST)
Message-ID: <528646bc0503020204696578eb@mail.gmail.com>
Date: Wed, 2 Mar 2005 03:04:23 -0700
From: Grant Likely <glikely@gmail.com>
To: Matthias Babylon <m.babylon@hima.com>
In-Reply-To: <000501c51f09$610e6ff0$f101a8c0@SN7605>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <000501c51f09$610e6ff0$f101a8c0@SN7605>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Dist
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2 Mar 2005 10:22:39 +0100, Matthias Babylon <m.babylon@hima.com> wrote:
> Hi all,
> 
> we actually desgin a new PowerPC 440GX based Dev-Board. The Problem is, we
> have no Linux Distribution with embedded ppc440gx support. can someone give
> me links to ibm440gx linux distributions homepages??

You could use gentoo, debian or build from scratch.  You can get
pretty much any PPC distribution to run.  Need more information to
give a good answer.  What are you trying to do with your platform?  Do
you have memory or disk constraints?  Do you need glibc or will uclibc
be sufficient?

Cheers,
g.
