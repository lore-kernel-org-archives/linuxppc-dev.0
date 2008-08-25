Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id 53746DE5DC
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 00:29:45 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1781762rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 07:29:43 -0700 (PDT)
Message-ID: <319b0ac50808250729i2043c4d6h57577e0a2eda7ed8@mail.gmail.com>
Date: Mon, 25 Aug 2008 16:29:43 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: initramfs vs initrd
In-Reply-To: <20080825131018.GA4199@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12329_19304415.1219674583781"
References: <319b0ac50808250557g4bd1d267t14e3bd8887c76e24@mail.gmail.com>
	<20080825131018.GA4199@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_12329_19304415.1219674583781
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok thank you



2008/8/25, Josh Boyer <jwboyer@linux.vnet.ibm.com>:
>
> On Mon, Aug 25, 2008 at 02:57:14PM +0200,
> =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
> >Hello,
> >
> >What is the difference between initramfs and initrd ?
>
>
> You could poke around in the Documentation directory of the kernel.  That
> should answer your question.
>
> Briefly, initramfs is a gzipped cpio archive.  initrd is typically a
> compressed ext2 filesystem and requires a ramdisk to be unpacked to.
>
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_12329_19304415.1219674583781
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok thank you<br>
<br>
<br>
<br><div><span class="gmail_quote">2008/8/25, Josh Boyer &lt;<a href="mailto:jwboyer@linux.vnet.ibm.com">jwboyer@linux.vnet.ibm.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, Aug 25, 2008 at 02:57:14PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:<br> &gt;Hello,<br> &gt;<br> &gt;What is the difference between initramfs and initrd ?<br> <br> <br>You could poke around in the Documentation directory of the kernel.&nbsp;&nbsp;That<br>
 should answer your question.<br> <br> Briefly, initramfs is a gzipped cpio archive.&nbsp;&nbsp;initrd is typically a<br> compressed ext2 filesystem and requires a ramdisk to be unpacked to.<br> <br> josh<br> _______________________________________________<br>
 Linuxppc-dev mailing list<br> <a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br> <a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br> </blockquote>
</div><br>

------=_Part_12329_19304415.1219674583781--
