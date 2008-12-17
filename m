Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id BAE59DDED3
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 23:47:26 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4531841rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 04:47:25 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 17 Dec 2008 07:47:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Manish Ahuja <mahuja@us.ibm.com>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] [RFC] Pass a valid token to rats_call() in phyp-dump code.
Message-ID: <20081217124700.GA2369@yoda.jdub.homelinux.org>
References: <20081216043429.GC14890@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081216043429.GC14890@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 16, 2008 at 03:34:43PM +1100, Tony Breeds wrote:
>ibm_configure_kernel_dump, is passed as the token to rtas_call() but I
>cannot see where it is initialised.  Set it to something sane?
>
>Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Seems sane as a fix, just a note that whoever needs to apply this
patch should fix the Subject line to say "rtas" and not "rats".

Though rats is applicable at times :)

josh
