Return-Path: <cristian.axenie@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 8BB6CDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 21:17:25 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so1875499fke.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 02:17:23 -0800 (PST)
Message-ID: <9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
Date: Sat, 15 Nov 2008 12:17:23 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: "Nicholas Mc Guire" <hofrat@hofr.at>, "Joachim Foerster" <mls.JOFT@gmx.de>,
	linuxppc-embedded@ozlabs.org
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16824_19873885.1226744243174"
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
	<Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_16824_19873885.1226744243174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Nov 15, 2008 at 12:01 PM, Nicholas Mc Guire <hofrat@hofr.at> wrote:

> >
> > >
> > >
> > > On Sat, Nov 15, 2008 at 10:18 AM, Joachim Foerster <mls.JOFT@gmx.de
> >wrote:
> > >
> > >> Hi Cristian,
> > >>
> > >> On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:
> > >> > VFS: Mounted root (ext2 filesystem) readonly.
> > >> > Freeing unused kernel memory: 156k init
> > >> > Warning: unable to open an initial console.
> > >>
> > >> Device file /dev/console doesn't seem to exist in your rootfs.
> > >
> > > Strange because /dev/console exists in my ext2.img.
>
> did you check that it is actually a valid character device (c 5 1) ?
> it can easaly happend during copying of a tree into your image that
> they become regular files.
>
> hofrat
>
I think that you are right, butr how can I test this validity??

Cristian

------=_Part_16824_19873885.1226744243174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Nov 15, 2008 at 12:01 PM, Nicholas Mc Guire <span dir="ltr">&lt;<a href="mailto:hofrat@hofr.at">hofrat@hofr.at</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Sat, Nov 15, 2008 at 10:18 AM, Joachim Foerster &lt;<a href="mailto:mls.JOFT@gmx.de">mls.JOFT@gmx.de</a>&gt;wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; Hi Cristian,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:<br>
&gt; &gt;&gt; &gt; VFS: Mounted root (ext2 filesystem) readonly.<br>
&gt; &gt;&gt; &gt; Freeing unused kernel memory: 156k init<br>
&gt; &gt;&gt; &gt; Warning: unable to open an initial console.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Device file /dev/console doesn&#39;t seem to exist in your rootfs.<br>
&gt; &gt;<br>
&gt; &gt; Strange because /dev/console exists in my ext2.img.<br>
<br>
</div>did you check that it is actually a valid character device (c 5 1) ?<br>
it can easaly happend during copying of a tree into your image that<br>
they become regular files.<br>
<br>
hofrat<br>
</blockquote></div>I think that you are right, butr how can I test this validity??<br><br>Cristian<br>

------=_Part_16824_19873885.1226744243174--
