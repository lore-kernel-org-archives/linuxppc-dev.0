Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id AE6D2DE00A
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 23:10:55 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so1235785wra.1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 06:10:53 -0700 (PDT)
Date: Mon, 25 Aug 2008 09:10:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/Uz1FOWJhc3RpZW5fQ2hyPUU5dGllbl8=?=
	<sebasti?==?ISO-8859-1?Q?en.chretien.enseirb@gmail.com>,
	?=@yoda.jdub.homelinux.org
Subject: Re: initramfs vs initrd
Message-ID: <20080825131018.GA4199@yoda.jdub.homelinux.org>
References: <319b0ac50808250557g4bd1d267t14e3bd8887c76e24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <319b0ac50808250557g4bd1d267t14e3bd8887c76e24@mail.gmail.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 25, 2008 at 02:57:14PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
>Hello,
>
>What is the difference between initramfs and initrd ?

You could poke around in the Documentation directory of the kernel.  That
should answer your question.

Briefly, initramfs is a gzipped cpio archive.  initrd is typically a
compressed ext2 filesystem and requires a ramdisk to be unpacked to.

josh
